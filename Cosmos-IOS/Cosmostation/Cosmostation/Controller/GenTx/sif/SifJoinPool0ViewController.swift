//
//  SifJoinPool0ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifJoinPool0ViewController: BaseViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func onClick0Clear(_ sender: UIButton) {
//        self.input0TextFiled.text = ""
//        onUIupdate0()
    }
    
    @IBAction func onClick01_4(_ sender: UIButton) {
//        let calValue = available0MaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -coin0Decimal, withBehavior: WUtils.getDivideHandler(coin0Decimal))
//        input0TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coin0Decimal)
//        onUIupdate0()
    }
    
    @IBAction func onClick0Half(_ sender: UIButton) {
//        let calValue = available0MaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.5")).multiplying(byPowerOf10: -coin0Decimal, withBehavior: WUtils.getDivideHandler(coin0Decimal))
//        input0TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coin0Decimal)
//        onUIupdate0()
    }
    
    @IBAction func onClick03_4(_ sender: UIButton) {
//        let calValue = available0MaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -coin0Decimal, withBehavior: WUtils.getDivideHandler(coin0Decimal))
//        input0TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coin0Decimal)
//        onUIupdate0()
    }
    
    @IBAction func onClick0Max(_ sender: UIButton) {
//        let maxValue = available0MaxAmount.multiplying(byPowerOf10: -coin0Decimal, withBehavior: WUtils.getDivideHandler(coin0Decimal))
//        input0TextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, coin0Decimal)
//        onUIupdate0()
    }
    
    @IBAction func onClick1Clear(_ sender: UIButton) {
//        self.input1TextFiled.text = ""
//        onUIupdate1()
    }
    
    @IBAction func onClick11_4(_ sender: UIButton) {
//        let calValue = available1MaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -coin1Decimal, withBehavior: WUtils.getDivideHandler(coin1Decimal))
//        input1TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coin1Decimal)
//        onUIupdate1()
    }
    
    @IBAction func onClick1Half(_ sender: UIButton) {
//        let calValue = available1MaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.5")).multiplying(byPowerOf10: -coin1Decimal, withBehavior: WUtils.getDivideHandler(coin1Decimal))
//        input1TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coin1Decimal)
//        onUIupdate1()
    }
    
    @IBAction func onClick13_4(_ sender: UIButton) {
//        let calValue = available1MaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -coin1Decimal, withBehavior: WUtils.getDivideHandler(coin1Decimal))
//        input1TextFiled.text = WUtils.decimalNumberToLocaleString(calValue, coin1Decimal)
//        onUIupdate1()
    }
    
    @IBAction func onClick1Max(_ sender: UIButton) {
//        let maxValue = available1MaxAmount.multiplying(byPowerOf10: -coin1Decimal, withBehavior: WUtils.getDivideHandler(coin1Decimal))
//        input1TextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, coin1Decimal)
//        onUIupdate1()
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
//        self.btnCancel.isUserInteractionEnabled = false
//        self.btnNext.isUserInteractionEnabled = false
//        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
    }
}
