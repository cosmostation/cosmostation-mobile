//
//  NewAccountTypePopup.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/21.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class NewAccountTypePopup: BaseViewController, SBCardPopupContent {
    var popupViewController: SBCardPopupViewController?
    let allowsTapToDismissPopupCard = true
    let allowsSwipeToDismissPopupCard = true

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapClose))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func onTapClose(sender: Any) {
        popupViewController?.close()
    }

    @IBAction func onClickMnemonic(_ sender: UIButton) {
        popupViewController?.resultDelegate?.SBCardPopupResponse(type: 0, result: 2)
        popupViewController?.close()
    }
    
    @IBAction func onClickPrivateKey(_ sender: UIButton) {
        popupViewController?.resultDelegate?.SBCardPopupResponse(type: 0, result: 4)
        popupViewController?.close()
    }
    
    @IBAction func onClickAddress(_ sender: UIButton) {
        popupViewController?.resultDelegate?.SBCardPopupResponse(type: 0, result: 3)
        popupViewController?.close()
    }
    
    @IBAction func onClickCreate(_ sender: UIButton) {
        popupViewController?.resultDelegate?.SBCardPopupResponse(type: 0, result: 1)
        popupViewController?.close()
    }
}
