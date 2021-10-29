//
//  BaseViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 05/03/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit
import Toast_Swift
import QRCode
import Alamofire
import SafariServices
import SwiftKeychainWrapper

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    if (SHOW_LOG) {
//        let output = items.map { "\($0)" }.joined(separator: separator)
//        Swift.print(output, terminator: terminator)
//    }
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    #endif
}

class BaseViewController: UIViewController {
    
    var account:Account?
    var chainType:ChainType?
    var balances = Array<Balance>()
    var waitAlert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startAvoidingKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopAvoidingKeyboard()
    }
    
    public func showWaittingAlert() {
        waitAlert = UIAlertController(title: "", message: "\n\n\n\n", preferredStyle: .alert)
        let image = LoadingImageView(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        waitAlert!.view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        waitAlert!.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: waitAlert!.view, attribute: .centerX, multiplier: 1, constant: 0))
        waitAlert!.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: waitAlert!.view, attribute: .centerY, multiplier: 1, constant: 0))
        waitAlert!.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 58.0))
        waitAlert!.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 58.0))
        WUtils.clearBackgroundColor(of: waitAlert!.view)
        self.present(waitAlert!, animated: true, completion: nil)
        image.onStartAnimation()
        
    }
    
    public func hideWaittingAlert() {
        if (waitAlert != nil) {
            waitAlert?.dismiss(animated: true, completion: nil)
        }
    }
    
    func onStartMainTab() {
        let mainTabVC = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainTabVC
        self.present(mainTabVC, animated: true, completion: nil)
    }
    
    
    func onStartImportMnemonic() {
        let restoreVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "RestoreViewController") as! RestoreViewController
        restoreVC.hidesBottomBarWhenPushed = true
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(restoreVC, animated: true)
    }
    
    func onStartImportAddress() {
        let addAddressVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        addAddressVC.hidesBottomBarWhenPushed = true
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    func onStartCreate() {
        let createVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
        createVC.hidesBottomBarWhenPushed = true
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    func onStartTxDetail(_ response:[String:Any]) {
        let txDetailVC = TxDetailViewController(nibName: "TxDetailViewController", bundle: nil)
        txDetailVC.mIsGen = true
        txDetailVC.mBroadCaseResult = response
        self.navigationItem.title = ""
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        self.navigationController?.pushViewController(txDetailVC, animated: true)
    }
    
    func onStartTxDetailgRPC(_ response: Cosmos_Tx_V1beta1_BroadcastTxResponse) {
        let txDetailVC = TxDetailgRPCViewController(nibName: "TxDetailgRPCViewController", bundle: nil)
        txDetailVC.mIsGen = true
        txDetailVC.mBroadCaseResult = response
        self.navigationItem.title = ""
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        self.navigationController?.pushViewController(txDetailVC, animated: true)
    }
    
    func onDeleteWallet(_ account:Account) {
        self.showWaittingAlert()
        self.onDeleteAlarm(account)
        DispatchQueue.global().async {
            BaseData.instance.deleteAccount(account: account)
            BaseData.instance.deleteBalance(account: account)
            
            if (KeychainWrapper.standard.hasValue(forKey: account.account_uuid.sha1())) {
                KeychainWrapper.standard.removeObject(forKey: account.account_uuid.sha1())
            }
            
            if (KeychainWrapper.standard.hasValue(forKey: account.getPrivateKeySha1())) {
                KeychainWrapper.standard.removeObject(forKey: account.getPrivateKeySha1())
            }
            
//            if (BaseData.instance.selectAllAccounts().count <= 0) {
//                //TODO delete password
//            } else {
//                BaseData.instance.setRecentAccountId(BaseData.instance.selectAllAccounts()[0].account_id)
//            }
            
            for chain in BaseData.instance.dpSortedChains() {
                let accountNum = BaseData.instance.selectAllAccountsByChain(chain).count
                if (accountNum > 0) {
                    BaseData.instance.setRecentAccountId(BaseData.instance.selectAllAccountsByChain(chain)[0].account_id)
                    break
                }
            }
            
            DispatchQueue.main.async(execute: {
                self.hideWaittingAlert()
                self.onShowToast(NSLocalizedString("wallet_delete_complete", comment: ""))
                
                let introVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "StartNavigation")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = introVC
                self.present(introVC, animated: true, completion: nil)
            });
        }
    }
    
    func onShowToast(_ text:String) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.gray
        self.view.makeToast(text, duration: 2.0, position: .bottom, style: style)
    }
    
    func shareAddress(_ address: String, _ nickName: String?) {
        var qrCode = QRCode(address)
        qrCode?.backgroundColor = CIColor(rgba: "EEEEEE")
        qrCode?.size = CGSize(width: 200, height: 200)
        
        let attributedString = NSAttributedString(string: nickName ?? "", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        let alert = UIAlertController(title: nickName, message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.init(hexString: "EEEEEE")
        alert.addAction(UIAlertAction(title: NSLocalizedString("share", comment: ""), style: .default, handler:  { _ in
            let shareTypeAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            shareTypeAlert.addAction(UIAlertAction(title: NSLocalizedString("share_text", comment: ""), style: .default, handler: { _ in
                let textToShare = [ address ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }))
            shareTypeAlert.addAction(UIAlertAction(title: NSLocalizedString("share_qr", comment: ""), style: .default, handler: { _ in
                let image = qrCode?.image
                let imageToShare = [ image! ]
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }))
            self.present(shareTypeAlert, animated: true) {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                shareTypeAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
            }
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("copy", comment: ""), style: .default, handler: { _ in
            UIPasteboard.general.string = address
            self.onShowToast(NSLocalizedString("address_copied", comment: ""))
        }))
        
        let image = UIImageView(image: qrCode?.image)
        image.contentMode = .scaleAspectFit
        alert.view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 140.0))
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 140.0))
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func onShowAddMenomicDialog() {
        let alert = UIAlertController(title: NSLocalizedString("alert_title_no_private_key", comment: ""), message: NSLocalizedString("alert_msg_no_private_key", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("add_mnemonic", comment: ""), style: .default, handler: { _ in
            self.onStartImportMnemonic()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onShowSafariWeb(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .popover
        present(safariViewController, animated: true, completion: nil)
    }
    
    func onChainSelected(_ chainType: ChainType) {
    }
    
    
}
extension BaseViewController {
    
    func startAvoidingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func stopAvoidingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self._onKeyboardFrameWillChangeNotificationReceived(notification as Notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self._onKeyboardFrameWillChangeNotificationReceived(notification as Notification)
    }
    
    @objc private func _onKeyboardFrameWillChangeNotificationReceived(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }

        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)

        let animationDuration: TimeInterval = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)

        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            self.additionalSafeAreaInsets.bottom = intersection.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    @objc func enableUserInteraction() {
    }
    
    @objc func disableUserInteraction() {
    }
    
    func onToggleAlarm(_ account: Account, completion: @escaping (Bool) -> ()) {
        let param = ["chain_id":WUtils.getChainTypeInt(account.account_base_chain),
                     "device_type":"ios",
                     "address":account.account_address,
                     "alarm_token":BaseData.instance.getFCMToken(),
                     "alarm_status":!account.account_push_alarm] as [String : Any]
        let request = Alamofire.request(CSS_PUSH_UPDATE, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary else {
                    completion(true)
                    return
                }
                let result = responseData.object(forKey: "result") as? Bool ?? false
                if (result) {
                    BaseData.instance.updatePushAlarm(account, !account.account_push_alarm)
                    completion(true)
                }
                completion(false)
                

            case .failure(let error):
                completion(false)
            }
        }
    }
    
    func onDeleteAlarm(_ account: Account) {
        let param = ["chain_id":WUtils.getChainTypeInt(account.account_base_chain),
                     "device_type":"ios",
                     "address":account.account_address,
                     "alarm_token":BaseData.instance.getFCMToken(),
                     "alarm_status":false] as [String : Any]
        let request = Alamofire.request(CSS_PUSH_UPDATE, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                print("res ", res)

            case .failure(let error):
                print("error ", error)
            }
        }
    }
    
    
    func onShowSelectChainDialog() {
        let showAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let cosmosAction = UIAlertAction(title: NSLocalizedString("chain_title_cosmos", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.COSMOS_MAIN)
        })
        cosmosAction.setValue(UIImage(named: "cosmosWhMain")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let irisAction = UIAlertAction(title: NSLocalizedString("chain_title_iris", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.IRIS_MAIN)
        })
        irisAction.setValue(UIImage(named: "irisWh")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let bnbAction = UIAlertAction(title: NSLocalizedString("chain_title_bnb", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.BINANCE_MAIN)
        })
        bnbAction.setValue(UIImage(named: "binanceChImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let okexAction = UIAlertAction(title: NSLocalizedString("chain_title_okex", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.OKEX_MAIN)
        })
        okexAction.setValue(UIImage(named: "okexChainImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let cryptoAction = UIAlertAction(title: NSLocalizedString("chain_title_crypto", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.CRYPTO_MAIN)
        })
        cryptoAction.setValue(UIImage(named: "chaincrypto")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let iovAction = UIAlertAction(title: NSLocalizedString("chain_title_iov", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.IOV_MAIN)
        })
        iovAction.setValue(UIImage(named: "chainStarname")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let kavaAction = UIAlertAction(title: NSLocalizedString("chain_title_kava", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.KAVA_MAIN)
        })
        kavaAction.setValue(UIImage(named: "kavaImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let bandAction = UIAlertAction(title: NSLocalizedString("chain_title_band", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.BAND_MAIN)
        })
        bandAction.setValue(UIImage(named: "chainBandprotocal")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let persisAction = UIAlertAction(title: NSLocalizedString("chain_title_persis", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.PERSIS_MAIN)
        })
        persisAction.setValue(UIImage(named: "chainpersistence")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let certikAction = UIAlertAction(title: NSLocalizedString("chain_title_certik", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.CERTIK_MAIN)
        })
        certikAction.setValue(UIImage(named: "certikChainImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let akashAction = UIAlertAction(title: NSLocalizedString("chain_title_akash", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.AKASH_MAIN)
        })
        akashAction.setValue(UIImage(named: "akashChainImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let sentinelAction = UIAlertAction(title: NSLocalizedString("chain_title_sentinel", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.SENTINEL_MAIN)
        })
        sentinelAction.setValue(UIImage(named: "chainsentinel")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let fetchAction = UIAlertAction(title: NSLocalizedString("chain_title_fetch", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.FETCH_MAIN)
        })
        fetchAction.setValue(UIImage(named: "chainfetchai")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let sifAction = UIAlertAction(title: NSLocalizedString("chain_title_sif", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.SIF_MAIN)
        })
        sifAction.setValue(UIImage(named: "chainsifchain")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let kiAction = UIAlertAction(title: NSLocalizedString("chain_title_ki", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.KI_MAIN)
        })
        kiAction.setValue(UIImage(named: "chainKifoundation")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let osmosisAction = UIAlertAction(title: NSLocalizedString("chain_title_osmosis", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.OSMOSIS_MAIN)
        })
        osmosisAction.setValue(UIImage(named: "chainOsmosis")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let mediAction = UIAlertAction(title: NSLocalizedString("chain_title_medi", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.MEDI_MAIN)
        })
        mediAction.setValue(UIImage(named: "chainMedibloc")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let emoneyAction = UIAlertAction(title: NSLocalizedString("chain_title_emoney", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.EMONEY_MAIN)
        })
        emoneyAction.setValue(UIImage(named: "chainEmoney")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let rizonAction = UIAlertAction(title: NSLocalizedString("chain_title_rizon", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.RIZON_MAIN)
        })
        rizonAction.setValue(UIImage(named: "chainRizon")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let junoAction = UIAlertAction(title: NSLocalizedString("chain_title_juno", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.JUNO_MAIN)
        })
        junoAction.setValue(UIImage(named: "chainJuno")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let regenAction = UIAlertAction(title: NSLocalizedString("chain_title_regen", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.REGEN_MAIN)
        })
        regenAction.setValue(UIImage(named: "chainRegen")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let bitcannaAction = UIAlertAction(title: NSLocalizedString("chain_title_bitcanna", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.BITCANA_MAIN)
        })
        bitcannaAction.setValue(UIImage(named: "chainBitcanna")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let secretAction = UIAlertAction(title: NSLocalizedString("chain_title_secret", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.SECRET_MAIN)
        })
        secretAction.setValue(UIImage(named: "secretChainImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        
        let altheaTestAction = UIAlertAction(title: NSLocalizedString("chain_title_althea_test", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.ALTHEA_TEST)
        })
        altheaTestAction.setValue(UIImage(named: "testnetAlthea")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let umeeTestAction = UIAlertAction(title: NSLocalizedString("chain_title_umee_test", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.UMEE_TEST)
        })
        umeeTestAction.setValue(UIImage(named: "testnetUmee")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let axelarTestAction = UIAlertAction(title: NSLocalizedString("chain_title_axelar_test", comment: ""), style: .default, handler: { _ in
            self.onChainSelected(ChainType.AXELAR_TEST)
        })
        axelarTestAction.setValue(UIImage(named: "testnetAxelar")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        showAlert.addAction(cosmosAction)
        showAlert.addAction(irisAction)
        showAlert.addAction(bnbAction)
        showAlert.addAction(okexAction)
        showAlert.addAction(kavaAction)
        showAlert.addAction(bandAction)
        showAlert.addAction(persisAction)
        showAlert.addAction(iovAction)
        showAlert.addAction(certikAction)
        showAlert.addAction(akashAction)
        showAlert.addAction(sentinelAction)
        showAlert.addAction(fetchAction)
        showAlert.addAction(cryptoAction)
        showAlert.addAction(sifAction)
        showAlert.addAction(kiAction)
        showAlert.addAction(rizonAction)
        showAlert.addAction(osmosisAction)
        showAlert.addAction(mediAction)
        showAlert.addAction(emoneyAction)
        showAlert.addAction(regenAction)
        showAlert.addAction(junoAction)
        showAlert.addAction(bitcannaAction)
        showAlert.addAction(secretAction)
        
        if (ChainType.SUPPRT_CHAIN().contains(ChainType.ALTHEA_TEST)) {
            showAlert.addAction(altheaTestAction)
        }
        if (ChainType.SUPPRT_CHAIN().contains(ChainType.UMEE_TEST)) {
            showAlert.addAction(umeeTestAction)
        }
        if (ChainType.SUPPRT_CHAIN().contains(ChainType.AXELAR_TEST)) {
            showAlert.addAction(axelarTestAction)
        }
        
        self.present(showAlert, animated: true, completion: nil)
    }
}
