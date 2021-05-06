//
//  SettingTableViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 25/03/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit
import SafariServices
import Toast_Swift
import LocalAuthentication

class SettingTableViewController: UITableViewController, PasswordViewDelegate, QrScannerDelegate {

    var mAccount: Account!
    var chainType: ChainType!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var currecyLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var appLockSwitch: UISwitch!
    @IBOutlet weak var bioTypeLabel: UILabel!
    @IBOutlet weak var bioSwitch: UISwitch!
    @IBOutlet weak var explorerLabel: UILabel!
    var hideBio = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mAccount = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        chainType = WUtils.getChainType(mAccount.account_base_chain)
        
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = "v " + appVersion
        }
        self.onUpdateCurrency()
        self.onUpdateMarket()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.explorerLabel.text = NSLocalizedString("mintscan_explorer", comment: "")
        
        let laContext = LAContext()
        let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        var error: NSError?
        
        appLockSwitch.setOn(BaseData.instance.getUsingAppLock(), animated: false)
        bioSwitch.setOn(BaseData.instance.getUsingBioAuth(), animated: false)
        
        if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            if error != nil { return }
            if #available(iOS 11.0, *) {
                switch laContext.biometryType {
                case .faceID:
                    bioTypeLabel.text = NSLocalizedString("faceID", comment: "")
                case .touchID:
                    bioTypeLabel.text = NSLocalizedString("touchID", comment: "")
                case .none:
                    bioTypeLabel.text = ""
                    break
                }
            }
        }
        self.checkBioAuth()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            if(indexPath.row == 0) {
                let accoutManageVC = WalletManageViewController(nibName: "WalletManageViewController", bundle: nil)
                accoutManageVC.hidesBottomBarWhenPushed = true
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(accoutManageVC, animated: true)
            }
            
        } else if (indexPath.section == 1) {
            if(indexPath.row == 2) {
                self.onShowCurrenyDialog()
                
            } else if(indexPath.row == 3) {
                //NO more coinmarketcap always using coingecko
//                self.onShowMarketDialog()
            }
            
        } else if (indexPath.section == 2) {
            if(indexPath.row == 0) {
                if(Locale.current.languageCode == "ko") {
                    guard let url = URL(string: "https://guide.cosmostation.io/app_wallet_ko.html") else { return }
                    self.onShowSafariWeb(url)
                    
                } else {
                    guard let url = URL(string: "https://guide.cosmostation.io/app_wallet_en.html") else { return }
                    self.onShowSafariWeb(url)
                }
                
            } else if(indexPath.row == 1) {
                let url = URL(string: "tg://resolve?domain=cosmostation")
                if(UIApplication.shared.canOpenURL(url!)) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                } else {
                    let alert = UIAlertController(title: NSLocalizedString("warnning", comment: ""), message: NSLocalizedString("error_no_telegram", comment: ""), preferredStyle: .alert)
                    let action = UIAlertAction(title: "Download And Install", style: .default, handler: { (UIAlertAction) in
                        let urlAppStore = URL(string: "itms-apps://itunes.apple.com/app/id686449807")
                        if(UIApplication.shared.canOpenURL(urlAppStore!))
                        {
                            UIApplication.shared.open(urlAppStore!, options: [:], completionHandler: nil)
                        }
                        
                    })
                    let actionCancel = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
                    alert.addAction(action)
                    alert.addAction(actionCancel)
                    self.present(alert, animated: true, completion: nil)
                }
                
            } else if(indexPath.row == 2) {
                if (chainType == ChainType.COSMOS_MAIN) {
                    guard let url = URL(string: EXPLORER_COSMOS_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.IRIS_MAIN) {
                    guard let url = URL(string: EXPLORER_IRIS_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.BINANCE_MAIN) {
                    guard let url = URL(string: EXPLORER_BINANCE_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.IOV_MAIN) {
                    guard let url = URL(string: EXPLORER_IOV_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.KAVA_MAIN) {
                    guard let url = URL(string: EXPLORER_KAVA_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.BAND_MAIN) {
                    guard let url = URL(string: EXPLORER_BAND_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.SECRET_MAIN) {
                    guard let url = URL(string: EXPLORER_SECRET_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.BINANCE_TEST) {
                    guard let url = URL(string: EXPLORER_BINANCE_TEST) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.KAVA_TEST) {
                    guard let url = URL(string: EXPLORER_KAVA_TEST) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.OKEX_MAIN) {
                    guard let url = URL(string: EXPLORER_OKEX_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.OKEX_TEST) {
                    guard let url = URL(string: EXPLORER_OKEX_TEST) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST) {
                    guard let url = URL(string: EXPLORER_CERTIK + "?net=" + BaseData.instance.getChainId()) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.AKASH_MAIN) {
                    guard let url = URL(string: EXPLORER_AKASH_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.PERSIS_MAIN) {
                    guard let url = URL(string: EXPLORER_PERSIS_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.SENTINEL_MAIN) {
                    guard let url = URL(string: EXPLORER_SENTINEL_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.FETCH_MAIN) {
                    guard let url = URL(string: EXPLORER_FETCH_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.SIF_MAIN) {
                    guard let url = URL(string: EXPLORER_SIF_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.CRYPTO_MAIN) {
                    guard let url = URL(string: EXPLORER_CRYPTO_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.KI_MAIN) {
                    guard let url = URL(string: EXPLORER_KI_MAIN) else { return }
                    self.onShowSafariWeb(url)
                    
                } else if (chainType == ChainType.COSMOS_TEST) {
                    guard let url = URL(string: EXPLORER_COSMOS_TEST) else { return }
                    self.onShowSafariWeb(url)
                    
                }
                
            } else if(indexPath.row == 3) {
                guard let url = URL(string: "https://www.cosmostation.io") else { return }
                self.onShowSafariWeb(url)
                
            } else if(indexPath.row == 4) {
                self.onShowStarnameWcDialog()
            }
            
        } else if (indexPath.section == 3) {
            if(indexPath.row == 0) {
                if(Locale.current.languageCode == "ko") {
                    guard let url = URL(string: "https://www.cosmostation.io/service_ko.html") else { return }
                    self.onShowSafariWeb(url)
                } else {
                    guard let url = URL(string: "https://www.cosmostation.io/service_en.html") else { return }
                    self.onShowSafariWeb(url)
                }
                
                
            } else if(indexPath.row == 1) {
                guard let url = URL(string: "https://github.com/cosmostation/cosmostation-mobile") else { return }
                self.onShowSafariWeb(url)
                
            } else if(indexPath.row == 2) {
                let urlAppStore = URL(string: "itms-apps://itunes.apple.com/app/id1459830339")
                if(UIApplication.shared.canOpenURL(urlAppStore!)) {
                    UIApplication.shared.open(urlAppStore!, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 1 && indexPath.row == 1) {
            if hideBio {
                return 0
            } else {
                return 44
            }
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func onUpdateCurrency() {
        currecyLabel.text = BaseData.instance.getCurrencyString()
    }
    
    func onUpdateMarket() {
        marketLabel.text = BaseData.instance.getMarketString()
    }
    
    
    func onShowToast(_ text:String) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.gray
        self.parent?.view.makeToast(text, duration: 2.0, position: .bottom, style: style)
    }
    
    func onShowCurrenyDialog() {
        let showAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let usdAction = UIAlertAction(title: NSLocalizedString("currency_usd", comment: ""), style: .default, handler: { _ in
            self.onSetCurrency(0)
        })
        
        let eurAction = UIAlertAction(title: NSLocalizedString("currency_eur", comment: ""), style: .default, handler: { _ in
            self.onSetCurrency(1)
        })
        
        let krwAction = UIAlertAction(title: NSLocalizedString("currency_krw", comment: ""), style: .default, handler: { _ in
            self.onSetCurrency(2)
        })
        
        let jpyAction = UIAlertAction(title: NSLocalizedString("currency_jpy", comment: ""), style: .default, handler: { _ in
            self.onSetCurrency(3)
        })
        
        let cnyAction = UIAlertAction(title: NSLocalizedString("currency_cny", comment: ""), style: .default, handler: { _ in
            self.onSetCurrency(4)
        })
        
        let btcAction = UIAlertAction(title: NSLocalizedString("currency_btc", comment: ""), style: .default, handler: { _ in
            self.onSetCurrency(5)
        })
        
        showAlert.addAction(usdAction)
        showAlert.addAction(eurAction)
        showAlert.addAction(krwAction)
        showAlert.addAction(jpyAction)
        showAlert.addAction(cnyAction)
        showAlert.addAction(btcAction)
        
        self.present(showAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            showAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func onSetCurrency(_ value:Int) {
        if(BaseData.instance.getCurrency() != value) {
            BaseData.instance.setCurrency(value)
            self.onUpdateCurrency()
            NotificationCenter.default.post(name: Notification.Name("refreshPrice"), object: nil, userInfo: nil)
        }
    }
    
    @IBAction func appLockToggle(_ sender: UISwitch) {
        if (BaseData.instance.hasPassword()) {
            if(sender.isOn) {
                BaseData.instance.setUsingAppLock(sender.isOn)
                self.checkBioAuth()
            } else {
                let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                self.navigationItem.title = ""
                self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
                passwordVC.mTarget = PASSWORD_ACTION_SIMPLE_CHECK
                passwordVC.resultDelegate = self
                passwordVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(passwordVC, animated: false)
            }
        } else {
            let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            self.navigationItem.title = ""
            self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
            passwordVC.mTarget = PASSWORD_ACTION_INIT
            passwordVC.resultDelegate = self
            passwordVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(passwordVC, animated: false)
        }
    }
    
    @IBAction func bioToggle(_ sender: UISwitch) {
        BaseData.instance.setUsingBioAuth(sender.isOn)
    }
    
    func checkBioAuth() {
        if(bioTypeLabel.text!.count > 0 && BaseData.instance.getUsingAppLock()) {
            self.hideBio = false
        } else {
            self.hideBio = true
        }
        self.tableView.reloadData()
    }
    
    @objc func dismissAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func passwordResponse(result: Int) {
        if (result == PASSWORD_RESUKT_OK) {
            BaseData.instance.setUsingAppLock(false)
        }
    }
    
    func onShowMarketDialog() {
        let showAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let geckoAction = UIAlertAction(title: NSLocalizedString("coingecko", comment: ""), style: .default, handler: { _ in
            self.onSetMarket(0)
        })
        geckoAction.setValue(UIImage(named: "coingeckoImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        let marketcapAction = UIAlertAction(title: NSLocalizedString("coinmarketcap", comment: ""), style: .default, handler: {_ in
            self.onSetMarket(1)
        })
        marketcapAction.setValue(UIImage(named: "coinmarketcapImg")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        showAlert.addAction(geckoAction)
        showAlert.addAction(marketcapAction)
        self.present(showAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            showAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func onSetMarket(_ value:Int) {
        if(BaseData.instance.getMarket() != value) {
            BaseData.instance.setMarket(value)
            self.onUpdateMarket()
            NotificationCenter.default.post(name: Notification.Name("refreshPrice"), object: nil, userInfo: nil)
        }
    }
    
    func onShowSafariWeb(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .popover
        present(safariViewController, animated: true, completion: nil)
    }
    
    func onShowStarnameWcDialog() {
        let starnameWCAlert = UIAlertController(title: NSLocalizedString("str_starname_walletconnect_alert_title", comment: ""), message: NSLocalizedString("str_starname_walletconnect_alert_msg", comment: ""), preferredStyle: .alert)
        starnameWCAlert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        starnameWCAlert.addAction(UIAlertAction(title: NSLocalizedString("continue", comment: ""), style: .default, handler: { _ in
            self.onStartQrCode()
        }))
        self.present(starnameWCAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            starnameWCAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func onStartQrCode() {
        let qrScanVC = QRScanViewController(nibName: "QRScanViewController", bundle: nil)
        qrScanVC.hidesBottomBarWhenPushed = true
        qrScanVC.resultDelegate = self
        self.navigationItem.title = ""
        self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
        self.navigationController?.pushViewController(qrScanVC, animated: false)
    }
    
    func scannedAddress(result: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(610), execute: {
            print("result ", result)
            let wcDetailVC = StarnameWalletConnectViewController(nibName: "StarnameWalletConnectViewController", bundle: nil)
            wcDetailVC.hidesBottomBarWhenPushed = true
            wcDetailVC.wcURL = result
            wcDetailVC.hidesBottomBarWhenPushed = true
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(wcDetailVC, animated: true)
            
        })
    }
    
}
