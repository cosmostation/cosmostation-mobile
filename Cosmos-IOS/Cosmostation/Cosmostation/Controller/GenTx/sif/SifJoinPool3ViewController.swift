//
//  SifJoinPool3ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifJoinPool3ViewController: BaseViewController {
    
    @IBOutlet weak var txFeeAmountLabel: UILabel!
    @IBOutlet weak var txFeeDenomLabel: UILabel!
    @IBOutlet weak var deposit0AmountLabel: UILabel!
    @IBOutlet weak var deposit0DenomLabel: UILabel!
    @IBOutlet weak var deposit1AmountLabel: UILabel!
    @IBOutlet weak var deposit1DenomLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickBack(_ sender: UIButton) {
//        self.btnBack.isUserInteractionEnabled = false
//        self.btnConfirm.isUserInteractionEnabled = false
//        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickConfirm(_ sender: UIButton) {
//        let passwordVC = UIStoryboard(name: "Password", bundle: nil).instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
//        self.navigationItem.title = ""
//        self.navigationController!.view.layer.add(WUtils.getPasswordAni(), forKey: kCATransition)
//        passwordVC.mTarget = PASSWORD_ACTION_CHECK_TX
//        passwordVC.resultDelegate = self
//        self.navigationController?.pushViewController(passwordVC, animated: false)
    }

}
