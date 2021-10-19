//
//  SifExitPool0ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifExitPool0ViewController: BaseViewController {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var loadingImg: LoadingImageView!
    @IBOutlet weak var lpCoinImg: UIImageView!
    @IBOutlet weak var lpCoinName: UILabel!
    @IBOutlet weak var lpAvailableLabel: UILabel!
    @IBOutlet weak var inputTextFiled: AmountInputTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onClickClear(_ sender: UIButton) {
//        self.inputTextFiled.text = ""
//        self.onUIupdate()
    }
    
    @IBAction func onClick1_4(_ sender: UIButton) {
//        let calValue = availableMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -coinDecimal, withBehavior: WUtils.getDivideHandler(coinDecimal))
//        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coinDecimal)
//        self.onUIupdate()
    }
    
    @IBAction func onClickHalf(_ sender: UIButton) {
//        let calValue = availableMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.5")).multiplying(byPowerOf10: -coinDecimal, withBehavior: WUtils.getDivideHandler(coinDecimal))
//        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coinDecimal)
//        self.onUIupdate()
    }
    
    @IBAction func onClick3_4(_ sender: UIButton) {
//        let calValue = availableMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -coinDecimal, withBehavior: WUtils.getDivideHandler(coinDecimal))
//        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coinDecimal)
//        self.onUIupdate()
    }
    
    @IBAction func onClickMax(_ sender: UIButton) {
//        let maxValue = availableMaxAmount.multiplying(byPowerOf10: -coinDecimal, withBehavior: WUtils.getDivideHandler(coinDecimal))
//        inputTextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, coinDecimal)
//        self.onUIupdate()
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
//        self.btnCancel.isUserInteractionEnabled = false
//        self.btnNext.isUserInteractionEnabled = false
//        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
    }

}
