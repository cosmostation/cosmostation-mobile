//
//  SifExitPool3ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import GRPC
import NIO

class SifExitPool3ViewController: BaseViewController, PasswordViewDelegate {
    
    @IBOutlet weak var txFeeAmountLabel: UILabel!
    @IBOutlet weak var txFeeDenomLabel: UILabel!
    @IBOutlet weak var lpAmountLabel: UILabel!
    @IBOutlet weak var withdraw0AmountLabel: UILabel!
    @IBOutlet weak var withdraw0DenomLabel: UILabel!
    @IBOutlet weak var withdraw1AmountLabel: UILabel!
    @IBOutlet weak var withdraw1DenomLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var pageHolderVC: StepGenTxViewController!
    var selectedPool: Sifnode_Clp_V1_Pool!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.pageHolderVC = self.parent as? StepGenTxViewController
        self.selectedPool = self.pageHolderVC.mSifPool
    }
    
    override func enableUserInteraction() {
        self.onUpdateView()
        self.btnBack.isUserInteractionEnabled = true
        self.btnConfirm.isUserInteractionEnabled = true
    }
    
    func onUpdateView() {
        WUtils.showCoinDp(pageHolderVC.mFee!.amount[0].denom, pageHolderVC.mFee!.amount[0].amount, txFeeDenomLabel, txFeeAmountLabel, chainType!)
        memoLabel.text = pageHolderVC.mMemo
        
        let lpRowanAmount = WUtils.getNativeLpAmount(selectedPool)
        let lpExternalAmount = WUtils.getExternalLpAmount(selectedPool)
        let lpUnitAmount = WUtils.getUnitAmount(selectedPool)
        let myShareAmount = NSDecimalNumber.init(string: pageHolderVC.mSifMyWithdrawUnitAmount)
        let rowanWithdrawAmount = lpRowanAmount.multiplying(by: myShareAmount).dividing(by: lpUnitAmount, withBehavior: WUtils.handler0)
        let externalWithdrawAmount = lpExternalAmount.multiplying(by: myShareAmount).dividing(by: lpUnitAmount, withBehavior: WUtils.handler0)
        
        lpAmountLabel.attributedText = WUtils.displayAmount2(lpUnitAmount.stringValue, lpAmountLabel.font, 18, 18)
        WUtils.showCoinDp(SIF_MAIN_DENOM, rowanWithdrawAmount.stringValue, withdraw0DenomLabel, withdraw0AmountLabel, chainType!)
        WUtils.showCoinDp(selectedPool.externalAsset.symbol, externalWithdrawAmount.stringValue, withdraw1DenomLabel, withdraw1AmountLabel, chainType!)
    }
    
    @IBAction func onClickBack(_ sender: UIButton) {
        self.btnBack.isUserInteractionEnabled = false
        self.btnConfirm.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickConfirm(_ sender: UIButton) {
        let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        self.navigationItem.title = ""
        self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
        passwordVC.mTarget = PASSWORD_ACTION_CHECK_TX
        passwordVC.resultDelegate = self
        self.navigationController?.pushViewController(passwordVC, animated: false)
    }
    
    func passwordResponse(result: Int) {
        if (result == PASSWORD_RESUKT_OK) {
            self.onFetchgRPCAuth(self.account!)
        }
    }
    
    
    func onFetchgRPCAuth(_ account: Account) {
        self.showWaittingAlert()
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Auth_V1beta1_QueryAccountRequest.with {
                $0.address = account.account_address
            }
            do {
                let response = try Cosmos_Auth_V1beta1_QueryClient(channel: channel).account(req).response.wait()
                self.onBroadcastGrpcTx(response)
            } catch {
                print("onFetchgRPCAuth failed: \(error)")
            }
        }
    }
    
    func onBroadcastGrpcTx(_ auth: Cosmos_Auth_V1beta1_QueryAccountResponse?) {
        DispatchQueue.global().async {
            guard let words = KeychainWrapper.standard.string(forKey: self.account!.account_uuid.sha1())?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ") else {
                return
            }
            let privateKey = KeyFac.getPrivateRaw(words, self.account!)
            let publicKey = KeyFac.getPublicRaw(words, self.account!)
            
            var basisPoints = ""
            let myShareAllAmount = NSDecimalNumber.init(string: self.pageHolderVC.mSifMyAllUnitAmount)
            let myShareWithdrawAmount = NSDecimalNumber.init(string: self.pageHolderVC.mSifMyWithdrawUnitAmount)
            basisPoints = myShareWithdrawAmount.multiplying(byPowerOf10: 4).dividing(by: myShareAllAmount, withBehavior: WUtils.handler0).stringValue
            print("basisPoints ", basisPoints)
            
            let reqTx = Signer.genSignedSifRemoveLpMsgTxgRPC(auth!,
                                                             self.account!.account_address,
                                                             self.selectedPool.externalAsset.symbol,
                                                             basisPoints,
                                                             self.pageHolderVC.mFee!,
                                                             self.pageHolderVC.mMemo!,
                                                             privateKey, publicKey,
                                                             BaseData.instance.getChainId(self.chainType))
            
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            do {
                let response = try Cosmos_Tx_V1beta1_ServiceClient(channel: channel).broadcastTx(reqTx).response.wait()
//                print("response ", response.txResponse.txhash)
                DispatchQueue.main.async(execute: {
                    if (self.waitAlert != nil) {
                        self.waitAlert?.dismiss(animated: true, completion: {
                            self.onStartTxDetailgRPC(response)
                        })
                    }
                });
            } catch {
                print("onBroadcastGrpcTx failed: \(error)")
            }
        }
    }
}
