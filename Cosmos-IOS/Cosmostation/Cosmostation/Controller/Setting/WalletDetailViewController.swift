//
//  WalletDetailViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 03/04/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit
import QRCode
import Alamofire
import UserNotifications
import GRPC
import NIO

class WalletDetailViewController: BaseViewController, PasswordViewDelegate {

    var accountId: Int64?
    
    @IBOutlet weak var cardAddress: CardView!
    @IBOutlet weak var chainImg: UIImageView!
    @IBOutlet weak var walletName: UILabel!
    @IBOutlet weak var walletAddress: UILabel!
    
    @IBOutlet weak var cardPush: CardView!
    @IBOutlet weak var pushMsg: UILabel!
    @IBOutlet weak var pushSwitch: UISwitch!
    
    @IBOutlet weak var cardInfo: CardView!
    @IBOutlet weak var chainName: UILabel!
    @IBOutlet weak var importDate: UILabel!
    @IBOutlet weak var importState: UILabel!
    @IBOutlet weak var pathTitle: UILabel!
    @IBOutlet weak var keyPath: UILabel!
    @IBOutlet weak var noKeyMsg: UILabel!
    
    @IBOutlet weak var cardReward: CardView!
    @IBOutlet weak var rewardCard: CardView!
    @IBOutlet weak var rewardAddress: UILabel!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    @IBOutlet weak var constraint1: NSLayoutConstraint!
    @IBOutlet weak var constraint2: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        account = BaseData.instance.selectAccountById(id: accountId!)
        chainType = WUtils.getChainType(account!.account_base_chain)
        
        if (WUtils.isGRPC(chainType!)) {
            self.onFetchRewardAddress_gRPC(account!.account_address)
            self.onFetchgRPCNodeInfo()
        } else {
            self.onFetchRewardAddress(account!.account_address)
            self.onFetchNodeInfo()
        }
        
        
        if (account!.account_nick_name == "") {
            walletName.text = NSLocalizedString("wallet_dash", comment: "") + String(account!.account_id)
        } else {
            walletName.text = account?.account_nick_name
        }
        
        walletAddress.text = account?.account_address
        walletAddress.adjustsFontSizeToFitWidth = true
        cardAddress.backgroundColor = WUtils.getChainBg(chainType!)
        cardPush.backgroundColor = WUtils.getChainBg(chainType!)
        pushSwitch.onTintColor = WUtils.getChainColor(chainType!)
        cardInfo.backgroundColor = WUtils.getChainBg(chainType!)
        cardReward.backgroundColor = WUtils.getChainBg(chainType!)
        if (chainType == ChainType.COSMOS_MAIN) {
            chainImg.image = UIImage(named: "cosmosWhMain")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            
        } else if (chainType == ChainType.IRIS_MAIN) {
            chainImg.image = UIImage(named: "irisWh")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.BINANCE_MAIN) {
            chainImg.image = UIImage(named: "binanceChImg")
            keyPath.text = BNB_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.KAVA_MAIN) {
            chainImg.image = UIImage(named: "kavaImg")
            if (account!.account_new_bip44) {
                keyPath.text = KAVA_BASE_PATH.appending(account!.account_path)
            } else {
                keyPath.text = BASE_PATH.appending(account!.account_path)
            }
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.IOV_MAIN) {
            chainImg.image = UIImage(named: "iovChainImg")
            keyPath.text = IOV_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.BAND_MAIN) {
            chainImg.image = UIImage(named: "bandChainImg")
            keyPath.text = BAND_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.SECRET_MAIN) {
            chainImg.image = UIImage(named: "secretChainImg")
            if (account!.account_new_bip44) {
                keyPath.text = BASE_PATH.appending(account!.account_path)
            } else {
                keyPath.text = SECRET_BASE_PATH.appending(account!.account_path)
            }
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.CERTIK_MAIN) {
            chainImg.image = UIImage(named: "certikChainImg")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.AKASH_MAIN) {
            chainImg.image = UIImage(named: "akashChainImg")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.OKEX_MAIN) {
            chainImg.image = UIImage(named: "okexChainImg")
            if (account!.account_new_bip44) { keyPath.text = "(Ethermint Type) " + OK_BASE_PATH.appending(account!.account_path) }
            else { keyPath.text = "(Tendermint Type) " + OK_BASE_PATH.appending(account!.account_path) }
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType! == ChainType.PERSIS_MAIN) {
            chainImg.image = UIImage(named: "chainpersistence")
            keyPath.text = PERSIS_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType! == ChainType.SENTINEL_MAIN) {
            chainImg.image = UIImage(named: "chainsentinel")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType! == ChainType.FETCH_MAIN) {
            chainImg.image = UIImage(named: "chainfetchai")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType! == ChainType.CRYPTO_MAIN) {
            chainImg.image = UIImage(named: "chaincrypto")
            keyPath.text = CRYPTO_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType! == ChainType.SIF_MAIN) {
            chainImg.image = UIImage(named: "chainsifchain")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType! == ChainType.KI_MAIN) {
            chainImg.image = UIImage(named: "chainKifoundation")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        }
        
        
        else if (chainType == ChainType.BINANCE_TEST) {
            chainImg.image = UIImage(named: "binancetestnet")
            keyPath.text = BNB_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.KAVA_TEST) {
            chainImg.image = UIImage(named: "kavaTestImg")
            if (account!.account_new_bip44) {
                keyPath.text = KAVA_BASE_PATH.appending(account!.account_path)
            } else {
                keyPath.text = BASE_PATH.appending(account!.account_path)
            }
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.OKEX_TEST) {
            chainImg.image = UIImage(named: "okexTestnetImg")
            if (account!.account_new_bip44) { keyPath.text = "(Ethermint Type) " + OK_BASE_PATH.appending(account!.account_path) }
            else { keyPath.text = "(Tendermint Type) " + OK_BASE_PATH.appending(account!.account_path) }
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.IOV_TEST) {
            chainImg.image = UIImage(named: "iovTestnetImg")
            keyPath.text = IOV_BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.CERTIK_TEST) {
            chainImg.image = UIImage(named: "certikTestnetImg")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        } else if (chainType == ChainType.COSMOS_TEST) {
            chainImg.image = UIImage(named: "cosmosTestChainImg")
            keyPath.text = BASE_PATH.appending(account!.account_path)
            cardPush.isHidden = true
            constraint2.priority = .defaultHigh
            constraint1.priority = .defaultLow
            
        }
        
        importDate.text = WUtils.longTimetoString(input:account!.account_import_time)
        
        if (account!.account_has_private)  {
            actionBtn.setTitle(NSLocalizedString("check_mnemonic", comment: ""), for: .normal)
            importState.text = NSLocalizedString("with_mnemonic", comment: "")
            pathTitle.isHidden = false
            keyPath.isHidden = false
            noKeyMsg.isHidden = true
            
        } else {
            actionBtn.setTitle(NSLocalizedString("import_address", comment: ""), for: .normal)
            importState.text = NSLocalizedString("only_address", comment: "")
            pathTitle.isHidden = true
            keyPath.isHidden = true
            noKeyMsg.isHidden = false
        }
        self.updatePushCardView()
        
    }
    
    func updatePushCardView() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    if (self.account!.account_push_alarm) {
                        self.pushSwitch.setOn(true, animated: false)
                        self.pushMsg.text = NSLocalizedString("push_enabled_state_msg", comment: "")
                    } else {
                        self.pushSwitch.setOn(false, animated: false)
                        self.pushMsg.text = NSLocalizedString("push_disabled_state_msg", comment: "")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.pushSwitch.setOn(false, animated: false)
                    self.pushMsg.text = NSLocalizedString("push_disabled_state_msg", comment: "")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_wallet_detail", comment: "")
        self.navigationItem.title = NSLocalizedString("title_wallet_detail", comment: "")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.stopAvoidingKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.topItem?.title = "";
    }

    
    @IBAction func onClickNameChange(_ sender: Any) {
        let nameAlert = UIAlertController(title: NSLocalizedString("change_wallet_name", comment: ""), message: nil, preferredStyle: .alert)
        
        nameAlert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("wallet_name", comment: "")
        }
        
        nameAlert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        nameAlert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { [weak nameAlert] (_) in
            let textField = nameAlert?.textFields![0]
            let trimmedString = textField?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if(trimmedString?.count ?? 0 > 0) {
                self.account!.account_nick_name = trimmedString!
                BaseData.instance.updateAccount(self.account!)
                BaseData.instance.setNeedRefresh(true)
                self.updateView()
            }
        }))
        self.present(nameAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            nameAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
    }
    
    @IBAction func onTogglePush(_ sender: UISwitch) {
        if (sender.isOn) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus == .authorized {
                    DispatchQueue.main.async {
                        self.showWaittingAlert()
                        self.onToggleAlarm(self.account!) { (success) in
                            self.account = BaseData.instance.selectAccountById(id: self.account!.account_id)
                            self.updatePushCardView()
                            self.dismissAlertController()
                        }
                    }
                    
                } else {
                    let alertController = UIAlertController(title: NSLocalizedString("permission_push_title", comment: ""), message: NSLocalizedString("permission_push_msg", comment: ""), preferredStyle: .alert)
                    let settingsAction = UIAlertAction(title: NSLocalizedString("settings", comment: ""), style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            })
                        }
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    alertController.addAction(settingsAction)
                    DispatchQueue.main.async {
                        sender.setOn(false, animated: true)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            DispatchQueue.main.async {
                self.showWaittingAlert()
                self.onToggleAlarm(self.account!) { (success) in
                    self.account = BaseData.instance.selectAccountById(id: self.account!.account_id)
                    self.updatePushCardView()
                    self.dismissAlertController()
                }
            }
        }
    }
    
    
    @IBAction func onClickQrCode(_ sender: Any) {
        var nickName:String?
        if (account!.account_nick_name == "") {
            nickName = NSLocalizedString("wallet_dash", comment: "") + String(account!.account_id)
        } else {
            nickName = account?.account_nick_name
        }
        self.shareAddress(account!.account_address, nickName!)
    }
    
    @IBAction func onClickRewardAddressChange(_ sender: UIButton) {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        
        if (WUtils.isGRPC(chainType!)) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_MIDIFY, 0)
            if (BaseData.instance.getAvailableAmount(WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else {
            let balances = BaseData.instance.selectBalanceById(accountId: account!.account_id)
            if (chainType == ChainType.IOV_MAIN) {
                if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(NSDecimalNumber.init(string: "1000000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.IOV_TEST) {
                if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(NSDecimalNumber.init(string: "1000000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
            } else if (chainType! == ChainType.SECRET_MAIN) {
                if (WUtils.getTokenAmount(balances, SECRET_MAIN_DENOM).compare(NSDecimalNumber.init(string: "20000")).rawValue <= 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType! == ChainType.CERTIK_MAIN || chainType! == ChainType.CERTIK_TEST) {
                if (WUtils.getTokenAmount(balances, CERTIK_MAIN_DENOM).compare(NSDecimalNumber.init(string: "5000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType! == ChainType.SENTINEL_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_MIDIFY, 0)
                if (WUtils.getTokenAmount(balances, SENTINEL_MAIN_DENOM).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType! == ChainType.FETCH_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_MIDIFY, 0)
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType! == ChainType.SIF_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_MIDIFY, 0)
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType! == ChainType.KI_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_MIDIFY, 0)
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else {
                self.onShowToast(NSLocalizedString("error_support_soon", comment: ""))//TODO
                return
            }
            
        }
        
        
        
        let title = NSLocalizedString("reward_address_notice_title", comment: "")
        let msg1 = NSLocalizedString("reward_address_notice_msg", comment: "")
        let msg2 = NSLocalizedString("reward_address_notice_msg2", comment: "")
        let msg = msg1 + msg2
        let range = (msg as NSString).range(of: msg2)
        let noticeAlert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let attributedMessage: NSMutableAttributedString = NSMutableAttributedString(
            string: msg,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)
            ]
        )
        attributedMessage.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14.0), range: range)
        attributedMessage.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        
        noticeAlert.setValue(attributedMessage, forKey: "attributedMessage")
        noticeAlert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        noticeAlert.addAction(UIAlertAction(title: NSLocalizedString("continue", comment: ""), style: .default, handler: { _ in
            BaseData.instance.setRecentAccountId(self.account!.account_id)
            let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
            txVC.mType = COSMOS_MSG_TYPE_WITHDRAW_MIDIFY
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(txVC, animated: true)
        }))
        self.present(noticeAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            noticeAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @IBAction func onClickActionBtn(_ sender: Any) {
        if(self.account!.account_has_private) {
            let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            self.navigationItem.title = ""
            self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
            passwordVC.mTarget = PASSWORD_ACTION_SIMPLE_CHECK
            passwordVC.resultDelegate = self
            self.navigationController?.pushViewController(passwordVC, animated: false)
            
        } else {
            self.onStartImportMnemonic()
        }
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        let deleteAlert = UIAlertController(title: NSLocalizedString("delete_wallet", comment: ""), message: NSLocalizedString("delete_wallet_msg", comment: ""), preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: { _ in
            self.confirmDelete()
        }))
        deleteAlert.addAction(UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(deleteAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            deleteAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func confirmDelete() {
        if (self.account!.account_has_private) {
            let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            self.navigationItem.title = ""
            self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
            passwordVC.mTarget = PASSWORD_ACTION_DELETE_ACCOUNT
            passwordVC.resultDelegate = self
            self.navigationController?.pushViewController(passwordVC, animated: false)
            
        } else {
            self.onDeleteWallet(account!)
        }
    }
    
    func passwordResponse(result: Int) {
        if (result == PASSWORD_RESUKT_OK) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(310), execute: {
                let walletCheckVC = WalletCheckViewController(nibName: "WalletCheckViewController", bundle: nil)
                walletCheckVC.hidesBottomBarWhenPushed = true
                walletCheckVC.accountId = self.accountId
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(walletCheckVC, animated: true)
            })
            
        } else if (result == PASSWORD_RESUKT_OK_FOR_DELETE) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(310), execute: {
                self.onDeleteWallet(self.account!)
            })
            
        }
    }
    
    func onFetchRewardAddress(_ accountAddr: String) {
        var url = ""
        if (chainType == ChainType.BAND_MAIN) {
            url = BAND_REWARD_ADDRESS + accountAddr + BAND_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_REWARD_ADDRESS + accountAddr + SECRET_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_REWARD_ADDRESS + accountAddr + CERTIK_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_REWARD_ADDRESS + accountAddr + IOV_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_REWARD_ADDRESS + accountAddr + SENTINEL_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_REWARD_ADDRESS + accountAddr + SIF_REWARD_ADDRESS_TAIL
        }
//        else if (chainType == ChainType.FETCH_MAIN) {
//            url = FETCH_REWARD_ADDRESS + accountAddr + FETCH_REWARD_ADDRESS_TAIL
//        }
        else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_REWARD_ADDRESS + accountAddr + IOV_TEST_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_REWARD_ADDRESS + accountAddr + CERTIK_TEST_REWARD_ADDRESS_TAIL
        }
        let request = Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]);
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary, let address = responseData.object(forKey: "result") as? String else {
                        return;
                }
                self.rewardCard.isHidden = false
                let trimAddress = address.replacingOccurrences(of: "\"", with: "")
                self.rewardAddress.text = trimAddress
                if (trimAddress != accountAddr) {
                    self.rewardAddress.textColor = UIColor.init(hexString: "f31963")
                }
                self.rewardAddress.adjustsFontSizeToFitWidth = true
                
            case .failure(let error):
                if(SHOW_LOG) { print("onFetchRewardAddress ", error) }
            }
        }
    }
    
    func onFetchRewardAddress_gRPC(_ address: String) {
        DispatchQueue.global().async {
            var responseAddress = ""
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Distribution_V1beta1_QueryDelegatorWithdrawAddressRequest.with {
                $0.delegatorAddress = address
            }
            do {
                let response = try Cosmos_Distribution_V1beta1_QueryClient(channel: channel).delegatorWithdrawAddress(req).response.wait()
                responseAddress = response.withdrawAddress.replacingOccurrences(of: "\"", with: "")
            } catch {
                print("onFetchRedelegation_gRPC failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.rewardAddress.text = responseAddress
                if (responseAddress != address) {
                    self.rewardAddress.textColor = UIColor.init(hexString: "f31963")
                }
                self.rewardAddress.adjustsFontSizeToFitWidth = true
                self.rewardCard.isHidden = false
            });
        }
    }
    
    
    func onFetchNodeInfo() {
        var url: String?
        if (self.chainType == ChainType.BINANCE_MAIN ) {
            url = BNB_URL_NODE_INFO
        } else if (self.chainType == ChainType.OKEX_MAIN) {
            url = OKEX_NODE_INFO
        } else if (self.chainType == ChainType.KAVA_MAIN) {
            url = KAVA_NODE_INFO
        } else if (self.chainType == ChainType.BAND_MAIN) {
            url = BAND_NODE_INFO
        } else if (self.chainType == ChainType.IOV_MAIN) {
            url = IOV_NODE_INFO
        } else if (self.chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_NODE_INFO
        } else if (self.chainType == ChainType.SECRET_MAIN) {
            url = SECRET_NODE_INFO
        } else if (self.chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_NODE_INFO
        } else if (self.chainType == ChainType.FETCH_MAIN) {
            url = FETCH_NODE_INFO
        } else if (self.chainType == ChainType.SIF_MAIN) {
            url = SIF_NODE_INFO
        }
        else if (self.chainType == ChainType.BINANCE_TEST) {
            url = BNB_TEST_URL_NODE_INFO
        } else if (self.chainType == ChainType.OKEX_TEST) {
            url = OKEX_TEST_NODE_INFO
        } else if (self.chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_NODE_INFO
        } else if (self.chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_NODE_INFO
        } else if (self.chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_NODE_INFO
        }
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary, let nodeInfo = responseData.object(forKey: "node_info") as? NSDictionary else {
                    return
                }
                self.chainName.text = NodeInfo.init(nodeInfo).network
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchTopValidatorsInfo ", error) }
            }
        }
    }
    
    func onFetchgRPCNodeInfo() {
        DispatchQueue.global().async {
            var chainId = ""
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest()
            
            do {
                let response = try Cosmos_Base_Tendermint_V1beta1_ServiceClient(channel: channel).getNodeInfo(req).response.wait()
                chainId = response.defaultNodeInfo.network
                
            } catch {
                print("onFetchgRPCNodeInfo failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.chainName.text = chainId
            });
        }
    }
    
}
