//
//  SifJoinPool0ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit
import GRPC
import NIO
import SwiftProtobuf

class SifJoinPool0ViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var loadingImg: LoadingImageView!
    @IBOutlet weak var inputCoin0Img: UIImageView!
    @IBOutlet weak var inputCoin0Name: UILabel!
    @IBOutlet weak var inputCoin0AvailableLabel: UILabel!
    @IBOutlet weak var inputCoin0AvailableDenomLabel: UILabel!
    @IBOutlet weak var input0TextFiled: AmountInputTextField!
    @IBOutlet weak var inputCoin1Img: UIImageView!
    @IBOutlet weak var inputCoin1Name: UILabel!
    @IBOutlet weak var inputCoin1AvailableLabel: UILabel!
    @IBOutlet weak var inputCoin1AvailableDenomLabel: UILabel!
    @IBOutlet weak var input1TextFiled: AmountInputTextField!
    
    var pageHolderVC: StepGenTxViewController!
    var selectedPool: Sifnode_Clp_V1_Pool!
    var rowanMaxAmount = NSDecimalNumber.zero
    var externalMaxAmount = NSDecimalNumber.zero
    var rowanDecimal:Int16 = 18
    var externalDecimal:Int16 = 18
    var depositRate = NSDecimalNumber.one
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.pageHolderVC = self.parent as? StepGenTxViewController
        self.selectedPool = self.pageHolderVC.mSifPool
        
        input0TextFiled.delegate = self
        input0TextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        input1TextFiled.delegate = self
        input1TextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        loadingImg.startAnimating()
        onFetchSifPool(selectedPool.externalAsset.symbol)
    }
    
    override func enableUserInteraction() {
        self.btnCancel.isUserInteractionEnabled = true
        self.btnNext.isUserInteractionEnabled = true
    }
    
    func onInitView() {
        let txFeeAmount = WUtils.getEstimateGasFeeAmount(chainType!, SIF_GAS_AMOUNT_LP, 0)
        rowanMaxAmount = BaseData.instance.getAvailableAmount_gRPC(SIF_MAIN_DENOM)
        rowanMaxAmount = rowanMaxAmount.subtracting(txFeeAmount)
        externalMaxAmount = BaseData.instance.getAvailableAmount_gRPC(selectedPool.externalAsset.symbol)
        externalDecimal = WUtils.getSifCoinDecimal(selectedPool.externalAsset.symbol)
        
        WUtils.DpSifCoinImg(inputCoin0Img, SIF_MAIN_DENOM)
        WUtils.DpSifCoinName(inputCoin0Name, SIF_MAIN_DENOM)
        WUtils.DpSifCoinImg(inputCoin1Img, selectedPool.externalAsset.symbol)
        WUtils.DpSifCoinName(inputCoin1Name, selectedPool.externalAsset.symbol)
        
        WUtils.showCoinDp(SIF_MAIN_DENOM, rowanMaxAmount.stringValue, inputCoin0AvailableDenomLabel, inputCoin0AvailableLabel, chainType!)
        WUtils.showCoinDp(selectedPool.externalAsset.symbol, externalMaxAmount.stringValue, inputCoin1AvailableDenomLabel, inputCoin1AvailableLabel, chainType!)
        
        let lpNativeAmount = WUtils.getPoolLpAmount(selectedPool, SIF_MAIN_DENOM)
        let lpExternalAmount = WUtils.getPoolLpAmount(selectedPool, selectedPool.externalAsset.symbol)
        depositRate = lpExternalAmount.dividing(by: lpNativeAmount, withBehavior: WUtils.handler24Down)
        print("depositRate ", depositRate)
        
        self.loadingImg.stopAnimating()
        self.loadingImg.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if (text.contains(".") && string.contains(".") && range.length == 0) { return false }
        if (text.count == 0 && string.starts(with: ".")) { return false }
        if (text.contains(",") && string.contains(",") && range.length == 0) { return false }
        if (text.count == 0 && string.starts(with: ",")) { return false }
        if (textField == input0TextFiled) {
            if let index = text.range(of: ".")?.upperBound {
                if(text.substring(from: index).count > (rowanDecimal - 1) && range.length == 0) { return false }
            }
            if let index = text.range(of: ",")?.upperBound {
                if(text.substring(from: index).count > (rowanDecimal - 1) && range.length == 0) { return false }
            }
            
        } else if (textField == input1TextFiled) {
            if let index = text.range(of: ".")?.upperBound {
                if(text.substring(from: index).count > (externalDecimal - 1) && range.length == 0) { return false }
            }
            if let index = text.range(of: ",")?.upperBound {
                if(text.substring(from: index).count > (externalDecimal - 1) && range.length == 0) { return false }
            }
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == input0TextFiled) {
            self.onUIupdate0()
        } else if (textField == input1TextFiled) {
            self.onUIupdate1()
        }
    }
    
    func onUIupdate0() {
        guard let text = input0TextFiled.text?.trimmingCharacters(in: .whitespaces) else {
            input0TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input1TextFiled.text = ""
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        if (text.count == 0) {
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
            input1TextFiled.text = ""
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        
        let userInput = WUtils.localeStringToDecimal(text)
        if (text.count > 1 && userInput == NSDecimalNumber.zero) {
            input0TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input1TextFiled.text = ""
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        if (userInput.compare(NSDecimalNumber.zero).rawValue <= 0) {
            input0TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input1TextFiled.text = ""
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        if (userInput.multiplying(byPowerOf10: rowanDecimal).compare(rowanMaxAmount).rawValue > 0) {
            input0TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input1TextFiled.text = ""
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        input0TextFiled.layer.borderColor = UIColor.white.cgColor
        
        let outputAmount = userInput.multiplying(byPowerOf10: rowanDecimal - externalDecimal).multiplying(by: depositRate, withBehavior: WUtils.handler24Down)
        input1TextFiled.text = WUtils.decimalNumberToLocaleString(outputAmount, externalDecimal)
        if ((outputAmount.multiplying(byPowerOf10: externalDecimal)).compare(externalMaxAmount).rawValue > 0) {
            input1TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
        } else {
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func onUIupdate1() {
        guard let text = input1TextFiled.text?.trimmingCharacters(in: .whitespaces) else {
            input1TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input0TextFiled.text = ""
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        if (text.count == 0) {
            input1TextFiled.layer.borderColor = UIColor.white.cgColor
            input0TextFiled.text = ""
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        
        let userInput = WUtils.localeStringToDecimal(text)
        if (text.count > 1 && userInput == NSDecimalNumber.zero) {
            input1TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input0TextFiled.text = ""
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        if (userInput.compare(NSDecimalNumber.zero).rawValue <= 0) {
            input1TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input0TextFiled.text = ""
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        if (userInput.multiplying(byPowerOf10: externalDecimal).compare(externalMaxAmount).rawValue > 0) {
            input1TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            input0TextFiled.text = ""
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        input1TextFiled.layer.borderColor = UIColor.white.cgColor
        
        let outputAmount = userInput.multiplying(byPowerOf10: externalDecimal - rowanDecimal).dividing(by: depositRate, withBehavior: WUtils.handler24Down)
        input0TextFiled.text = WUtils.decimalNumberToLocaleString(outputAmount, rowanDecimal)
        if ((outputAmount.multiplying(byPowerOf10: rowanDecimal)).compare(rowanMaxAmount).rawValue > 0) {
            input0TextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
        } else {
            input0TextFiled.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    
    @IBAction func onClick0Clear(_ sender: UIButton) {
        self.input0TextFiled.text = ""
        onUIupdate0()
    }
    
    @IBAction func onClick01_4(_ sender: UIButton) {
        let calValue = rowanMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -rowanDecimal, withBehavior: WUtils.getDivideHandler(rowanDecimal))
        input0TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, rowanDecimal)
        onUIupdate0()
    }
    
    @IBAction func onClick0Half(_ sender: UIButton) {
        let calValue = rowanMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.5")).multiplying(byPowerOf10: -rowanDecimal, withBehavior: WUtils.getDivideHandler(rowanDecimal))
        input0TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, rowanDecimal)
        onUIupdate0()
    }
    
    @IBAction func onClick03_4(_ sender: UIButton) {
        let calValue = rowanMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -rowanDecimal, withBehavior: WUtils.getDivideHandler(rowanDecimal))
        input0TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, rowanDecimal)
        onUIupdate0()
    }
    
    @IBAction func onClick0Max(_ sender: UIButton) {
        let maxValue = rowanMaxAmount.multiplying(byPowerOf10: -rowanDecimal, withBehavior: WUtils.getDivideHandler(rowanDecimal))
        input0TextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, rowanDecimal)
        onUIupdate0()
    }
    
    @IBAction func onClick1Clear(_ sender: UIButton) {
        self.input1TextFiled.text = ""
        onUIupdate1()
    }
    
    @IBAction func onClick11_4(_ sender: UIButton) {
        let calValue = externalMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -externalDecimal, withBehavior: WUtils.getDivideHandler(externalDecimal))
        input1TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, externalDecimal)
        onUIupdate1()
    }
    
    @IBAction func onClick1Half(_ sender: UIButton) {
        let calValue = externalMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.5")).multiplying(byPowerOf10: -externalDecimal, withBehavior: WUtils.getDivideHandler(externalDecimal))
        input1TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, externalDecimal)
        onUIupdate1()
    }
    
    @IBAction func onClick13_4(_ sender: UIButton) {
        let calValue = externalMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -externalDecimal, withBehavior: WUtils.getDivideHandler(externalDecimal))
        input1TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, externalDecimal)
        onUIupdate1()
    }
    
    @IBAction func onClick1Max(_ sender: UIButton) {
        let maxValue = externalMaxAmount.multiplying(byPowerOf10: -externalDecimal, withBehavior: WUtils.getDivideHandler(externalDecimal))
        input1TextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, externalDecimal)
        onUIupdate1()
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        self.btnCancel.isUserInteractionEnabled = false
        self.btnNext.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
        if (isValiadAmount()) {
            //To Deposit Tokens
            let pool0Amount = WUtils.localeStringToDecimal((input0TextFiled.text?.trimmingCharacters(in: .whitespaces))!).multiplying(byPowerOf10: rowanDecimal)
            let pool1Amount = WUtils.localeStringToDecimal((input1TextFiled.text?.trimmingCharacters(in: .whitespaces))!).multiplying(byPowerOf10: externalDecimal)
            pageHolderVC.mPoolCoin0 = Coin.init(SIF_MAIN_DENOM, pool0Amount.stringValue)
            pageHolderVC.mPoolCoin1 = Coin.init(selectedPool.externalAsset.symbol, pool1Amount.stringValue)
            sender.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
        } else {
            self.onShowToast(NSLocalizedString("error_amount", comment: ""))
        }
    }
    
    
    func isValiadAmount() -> Bool {
        let text0 = input0TextFiled.text?.trimmingCharacters(in: .whitespaces)
        if (text0 == nil || text0!.count == 0) { return false }
        let userInput0 = WUtils.localeStringToDecimal(text0!)
        if (userInput0.compare(NSDecimalNumber.zero).rawValue <= 0) { return false }
        if (userInput0.multiplying(byPowerOf10: rowanDecimal).compare(rowanMaxAmount).rawValue > 0) { return false }
        
        let text1 = input1TextFiled.text?.trimmingCharacters(in: .whitespaces)
        if (text1 == nil || text1!.count == 0) { return false }
        let userInput1 = WUtils.localeStringToDecimal(text1!)
        if (userInput1.compare(NSDecimalNumber.zero).rawValue <= 0) { return false }
        if (userInput1.multiplying(byPowerOf10: externalDecimal).compare(externalMaxAmount).rawValue > 0) { return false }
        
        return true
    }
    
    func onFetchSifPool(_ denom: String) {
        DispatchQueue.global().async {
            do {
                let channel = BaseNetWork.getConnection(self.chainType!, MultiThreadedEventLoopGroup(numberOfThreads: 1))!
                let req = Sifnode_Clp_V1_PoolReq.with { $0.symbol = denom }
                if let response = try? Sifnode_Clp_V1_QueryClient(channel: channel).getPool(req, callOptions: BaseNetWork.getCallOptions()).response.wait() {
                    self.selectedPool = response.pool
                }
                try channel.close().wait()
                
            } catch {
                print("onFetchSifPool failed: \(error)")
            }
            DispatchQueue.main.async(execute: { self.onInitView() });
        }
    }
}
