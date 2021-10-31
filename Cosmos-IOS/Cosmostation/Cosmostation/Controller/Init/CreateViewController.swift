//
//  CreateViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 25/03/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit
import HDWalletKit
import SwiftKeychainWrapper

class CreateViewController: BaseViewController, PasswordViewDelegate{
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var warningMsgLabel: UILabel!
    
    @IBOutlet weak var addressView: CardView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mnemonicView: CardView!
    
    
    @IBOutlet weak var mneminicLayer0: UIView!
    @IBOutlet weak var mneminicLayer1: UIView!
    @IBOutlet weak var mneminicLayer2: UIView!
    @IBOutlet weak var mneminicLayer3: UIView!
    @IBOutlet weak var mneminicLayer4: UIView!
    @IBOutlet weak var mneminicLayer5: UIView!
    @IBOutlet weak var mneminicLayer6: UIView!
    @IBOutlet weak var mneminicLayer7: UIView!
    @IBOutlet weak var mneminicLayer8: UIView!
    @IBOutlet weak var mneminicLayer9: UIView!
    @IBOutlet weak var mneminicLayer10: UIView!
    @IBOutlet weak var mneminicLayer11: UIView!
    @IBOutlet weak var mneminicLayer12: UIView!
    @IBOutlet weak var mneminicLayer13: UIView!
    @IBOutlet weak var mneminicLayer14: UIView!
    @IBOutlet weak var mneminicLayer15: UIView!
    @IBOutlet weak var mneminicLayer16: UIView!
    @IBOutlet weak var mneminicLayer17: UIView!
    @IBOutlet weak var mneminicLayer18: UIView!
    @IBOutlet weak var mneminicLayer19: UIView!
    @IBOutlet weak var mneminicLayer20: UIView!
    @IBOutlet weak var mneminicLayer21: UIView!
    @IBOutlet weak var mneminicLayer22: UIView!
    @IBOutlet weak var mneminicLayer23: UIView!
    
    @IBOutlet weak var mnemonic0: UILabel!
    @IBOutlet weak var mnemonic1: UILabel!
    @IBOutlet weak var mnemonic2: UILabel!
    @IBOutlet weak var mnemonic3: UILabel!
    @IBOutlet weak var mnemonic4: UILabel!
    @IBOutlet weak var mnemonic5: UILabel!
    @IBOutlet weak var mnemonic6: UILabel!
    @IBOutlet weak var mnemonic7: UILabel!
    @IBOutlet weak var mnemonic8: UILabel!
    @IBOutlet weak var mnemonic9: UILabel!
    @IBOutlet weak var mnemonic10: UILabel!
    @IBOutlet weak var mnemonic11: UILabel!
    @IBOutlet weak var mnemonic12: UILabel!
    @IBOutlet weak var mnemonic13: UILabel!
    @IBOutlet weak var mnemonic14: UILabel!
    @IBOutlet weak var mnemonic15: UILabel!
    @IBOutlet weak var mnemonic16: UILabel!
    @IBOutlet weak var mnemonic17: UILabel!
    @IBOutlet weak var mnemonic18: UILabel!
    @IBOutlet weak var mnemonic19: UILabel!
    @IBOutlet weak var mnemonic20: UILabel!
    @IBOutlet weak var mnemonic21: UILabel!
    @IBOutlet weak var mnemonic22: UILabel!
    @IBOutlet weak var mnemonic23: UILabel!
    
    @IBOutlet weak var warningView: UIView!
    
    var mnemonicLayers: [UIView] = [UIView]()
    var mnemonicLabels: [UILabel] = [UILabel]()
    var mnemonicWords: [String]?
    var checkedPassword: Bool = false
    var dpAddress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mnemonicLayers = [self.mneminicLayer0, self.mneminicLayer1, self.mneminicLayer2, self.mneminicLayer3,
                               self.mneminicLayer4, self.mneminicLayer5, self.mneminicLayer6, self.mneminicLayer7,
                               self.mneminicLayer8, self.mneminicLayer9, self.mneminicLayer10, self.mneminicLayer11,
                               self.mneminicLayer12, self.mneminicLayer13, self.mneminicLayer14, self.mneminicLayer15,
                               self.mneminicLayer16, self.mneminicLayer17, self.mneminicLayer18, self.mneminicLayer19,
                               self.mneminicLayer20, self.mneminicLayer21, self.mneminicLayer22, self.mneminicLayer23]
        
        self.mnemonicLabels = [self.mnemonic0, self.mnemonic1, self.mnemonic2, self.mnemonic3,
                               self.mnemonic4, self.mnemonic5, self.mnemonic6, self.mnemonic7,
                               self.mnemonic8, self.mnemonic9, self.mnemonic10, self.mnemonic11,
                               self.mnemonic12, self.mnemonic13, self.mnemonic14, self.mnemonic15,
                               self.mnemonic16, self.mnemonic17, self.mnemonic18, self.mnemonic19,
                               self.mnemonic20, self.mnemonic21, self.mnemonic22, self.mnemonic23]
    
        self.addressView.isHidden = true
        self.mnemonicView.isHidden = true
        self.warningView.isHidden = true
        self.nextBtn.isHidden = true
        
        if (chainType == nil) {
            self.onShowSelectChainDialog()
        } else {
            self.onGenNewKey()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_create", comment: "")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func onChainSelected(_ chainType: ChainType) {
        self.chainType = chainType
        self.onGenNewKey()
    }
    
    func onGenNewKey() {
        guard let words = try? Mnemonic.create(strength: .hight, language: .english) else {
            return
        }
        self.mnemonicWords = words.components(separatedBy: " ")
        self.onUpdateView()
    }
    
    func onUpdateView() {
        self.showWaittingAlert()
        DispatchQueue.global().async {
            //secret toggle!!!
            if (self.chainType! == ChainType.SECRET_MAIN) {
                self.dpAddress = WKey.getDpAddressPath(self.mnemonicWords!, 0, self.chainType!, false)
            } else {
                self.dpAddress = WKey.getDpAddressPath(self.mnemonicWords!, 0, self.chainType!, true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.hideWaittingAlert()
                var address = self.dpAddress
                if (self.chainType == ChainType.OKEX_MAIN || self.chainType  == ChainType.OKEX_TEST) {
                    address = WKey.convertAddressOkexToEth(address!)
                }
                self.addressLabel.text = address
                self.mnemonicView.backgroundColor = WUtils.getChainBg(self.chainType!)
                for i in 0 ... self.mnemonicLabels.count - 1{
                    self.mnemonicLayers[i].layer.borderWidth = 1
                    self.mnemonicLayers[i].layer.cornerRadius = 4
                    self.mnemonicLayers[i].layer.borderColor = WUtils.getChainDarkColor(self.chainType!).cgColor
                }
                self.addressView.isHidden = false
                self.mnemonicView.isHidden = false
                self.warningView.isHidden = false
                self.nextBtn.isHidden = false

                for i in 0 ... self.mnemonicWords!.count - 1{
                    if(self.checkedPassword) {
                        self.mnemonicLabels[i].text = self.mnemonicWords?[i]
                        self.mnemonicLabels[i].adjustsFontSizeToFitWidth = true
                    } else {
                        self.mnemonicLabels[i].text = ""
                    }
                }

                if (self.checkedPassword) {
                    self.warningMsgLabel.text = NSLocalizedString("password_msg2", comment: "")
                    self.nextBtn.setTitle(NSLocalizedString("create_wallet", comment: ""), for: .normal)
                } else {
                    self.warningMsgLabel.text = NSLocalizedString("password_msg1", comment: "")
                    self.nextBtn.setTitle(NSLocalizedString("show_mnemonics", comment: ""), for: .normal)
                }
            }
        }
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if (checkedPassword) {
            onGenAccount(chainType!)

        } else {
            let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            self.navigationItem.title = ""
            self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
            passwordVC.resultDelegate = self
            if(!BaseData.instance.hasPassword()) {
                passwordVC.mTarget = PASSWORD_ACTION_INIT
            } else  {
                passwordVC.mTarget = PASSWORD_ACTION_SIMPLE_CHECK
            }
            self.navigationController?.pushViewController(passwordVC, animated: false)
        }
    }
    
    func passwordResponse(result: Int) {
        if (result == PASSWORD_RESUKT_OK) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(310), execute: {
                self.checkedPassword = true
                self.onUpdateView()
            })
        }
    }
    
    func onGenAccount(_ chain:ChainType) {
        self.showWaittingAlert()
        DispatchQueue.global().async {
            
            let newAccount = Account.init(isNew: true)
            newAccount.account_path = "0"
            newAccount.account_address = self.dpAddress!
            newAccount.account_base_chain = WUtils.getChainDBName(chain)
            
            var resource: String = ""
            for word in self.mnemonicWords! {
                resource = resource + " " + word
            }
            let mnemonoicResult = KeychainWrapper.standard.set(resource, forKey: newAccount.account_uuid.sha1(), withAccessibility: .afterFirstUnlockThisDeviceOnly)
            
            var insertResult :Int64 = -1
            if (mnemonoicResult) {
                newAccount.account_has_private = true
                newAccount.account_from_mnemonic = true
                newAccount.account_m_size = 24
                newAccount.account_import_time = Date().millisecondsSince1970
                if (chain == ChainType.KAVA_MAIN || chain == ChainType.KAVA_TEST || chain == ChainType.OKEX_MAIN || chain == ChainType.OKEX_TEST) {
                    newAccount.account_new_bip44 = true
                }
                newAccount.account_sort_order = 9999
                insertResult = BaseData.instance.insertAccount(newAccount)
                
                if (insertResult < 0) {
                    KeychainWrapper.standard.removeObject(forKey: newAccount.account_uuid.sha1())
                    KeychainWrapper.standard.removeObject(forKey: newAccount.getPrivateKeySha1())
                }
            }
            
            DispatchQueue.main.async(execute: {
                self.hideWaittingAlert()
                if (mnemonoicResult && insertResult > 0) {
                    var hiddenChains = BaseData.instance.userHideChains()
                    if (hiddenChains.contains(chain)) {
                        if let position = hiddenChains.firstIndex { $0 == chain } {
                            hiddenChains.remove(at: position)
                        }
                        BaseData.instance.setUserHiddenChains(hiddenChains)
                    }
                    BaseData.instance.setLastTab(0)
                    BaseData.instance.setRecentAccountId(insertResult)
                    BaseData.instance.setRecentChain(chain)
                    self.onStartMainTab()
                }
            });
        }
    }

}
