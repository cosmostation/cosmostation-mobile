//
//  StepDelegateMemoViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 08/04/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit


class StepMemoViewController: BaseViewController, UITextViewDelegate, QrScannerDelegate, SBCardPopupDelegate {

    @IBOutlet weak var memoInputTextView: MemoTextView!
    @IBOutlet weak var memoCntLabel: UILabel!
    @IBOutlet weak var beforeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var memoControlLayer: UIStackView!
    @IBOutlet weak var emptyMemoIcon: UIImageView!
    @IBOutlet weak var emptyMemoMsg: UILabel!
    
    var pageHolderVC: StepGenTxViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageHolderVC = self.parent as? StepGenTxViewController
        
        memoInputTextView.tintColor = UIColor.init(hexString: "FFFFFF")
        memoInputTextView.delegate = self
        
        (NSClassFromString("UICalloutBarButton")! as! UIButton.Type).appearance().backgroundColor = UIColor.white
        (NSClassFromString("UICalloutBarButton")! as! UIButton.Type).appearance().setTitleColor(UIColor.black, for: .normal)
        
        chainType = pageHolderVC.chainType!
        if (chainType == ChainType.BINANCE_MAIN || chainType == ChainType.BINANCE_TEST) {
            memoCntLabel.text = "0/100 byte"
        } else {
            memoCntLabel.text = "0/255 byte"
        }
        
        if (isTransfer()) {
            self.memoControlLayer.isHidden = false
            self.emptyMemoIcon.isHidden = false
            self.emptyMemoMsg.isHidden = false
        } else {
            self.memoControlLayer.isHidden = true
            self.emptyMemoIcon.isHidden = true
            self.emptyMemoMsg.isHidden = true
        }
    }

    @IBAction func onClickBack(_ sender: Any) {
        self.beforeBtn.isUserInteractionEnabled = false
        self.nextBtn.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if (isValiadMemoSize()) {
            if (WKey.isMemohasMnemonic(memoInputTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))) {
                showMemoMnemonicWarn()
            } else {
                if (memoInputTextView.text != nil && memoInputTextView.text.count > 0) {
                    pageHolderVC.mMemo = memoInputTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                } else {
                    pageHolderVC.mMemo = ""
                }
                self.beforeBtn.isUserInteractionEnabled = false
                self.nextBtn.isUserInteractionEnabled = false
                pageHolderVC.onNextPage()
            }

        } else {
            self.onShowToast(NSLocalizedString("error_memo", comment: ""))
        }
    }
    
    @IBAction func onClickQrCode(_ sender: UIButton) {
        let qrScanVC = QRScanViewController(nibName: "QRScanViewController", bundle: nil)
        qrScanVC.hidesBottomBarWhenPushed = true
        qrScanVC.resultDelegate = self
        self.navigationItem.title = ""
        self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
        self.navigationController?.pushViewController(qrScanVC, animated: false)
    }
    
    @IBAction func onClickPaste(_ sender: UIButton) {
        if let myString = UIPasteboard.general.string {
            self.memoInputTextView.text = myString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        } else {
            self.onShowToast(NSLocalizedString("error_no_clipboard", comment: ""))
        }
    }
    
    override func enableUserInteraction() {
        self.beforeBtn.isUserInteractionEnabled = true
        self.nextBtn.isUserInteractionEnabled = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let byteArray = [UInt8](textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).utf8)
        if (chainType == ChainType.BINANCE_MAIN || chainType == ChainType.BINANCE_TEST) {
            memoCntLabel.text = String(byteArray.count) + "/100 byte"
            if (byteArray.count > 100) {
                self.memoInputTextView.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            } else {
                self.memoInputTextView.layer.borderColor = UIColor.white.cgColor
            }
            
        } else {
            memoCntLabel.text = String(byteArray.count) + "/255 byte"
            if (byteArray.count > 255) {
                self.memoInputTextView.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            } else {
                self.memoInputTextView.layer.borderColor = UIColor.white.cgColor
            }
            
        }
    }
    
    func isValiadMemoSize() -> Bool {
        let byteArray = [UInt8](memoInputTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).utf8)
        if (chainType == ChainType.BINANCE_MAIN || chainType == ChainType.BINANCE_TEST) {
            if (byteArray.count > 100) {
                return false
            }
        } else {
            if (byteArray.count > 255) {
                return false
            }
        }
        return true
    }
    
    func scannedAddress(result: String) {
        self.memoInputTextView.text = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isTransfer() -> Bool {
        var result = true
        let type = self.pageHolderVC.mType
        if (type == COSMOS_MSG_TYPE_TRANSFER2) {
            result = true
        } else {
            result = false
        }
        return result
    }
    
    func showMemoMnemonicWarn() {
        let popupVC = MemoMnemonicPopup(nibName: "MemoMnemonicPopup", bundle: nil)
        let cardPopup = SBCardPopupViewController(contentViewController: popupVC)
        cardPopup.resultDelegate = self
        cardPopup.show(onViewController: self)
        
    }
    
    func SBCardPopupResponse(type:Int, result: Int) {
        if (result == -1) {
            self.memoInputTextView.text = ""
            if (chainType == ChainType.BINANCE_MAIN || chainType == ChainType.BINANCE_TEST) {
                memoCntLabel.text = "0/100 byte"
            } else {
                memoCntLabel.text = "0/255 byte"
            }
            
        } else {
            if (memoInputTextView.text != nil && memoInputTextView.text.count > 0) {
                pageHolderVC.mMemo = memoInputTextView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            } else {
                pageHolderVC.mMemo = ""
            }
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
        }
        
    }
}
