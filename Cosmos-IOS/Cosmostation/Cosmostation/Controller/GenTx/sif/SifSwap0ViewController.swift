//
//  SifSwap0ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit
import GRPC
import NIO
import SwiftProtobuf

class SifSwap0ViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var loadingImg: LoadingImageView!
    @IBOutlet weak var inputCoinImg: UIImageView!
    @IBOutlet weak var inputCoinName: UILabel!
    @IBOutlet weak var inputCoinAvailableLabel: UILabel!
    @IBOutlet weak var inputCoinAvailableDenomLabel: UILabel!
    @IBOutlet weak var inputTextFiled: AmountInputTextField!
    @IBOutlet weak var outputCoinImg: UIImageView!
    @IBOutlet weak var outputCoinName: UILabel!
    @IBOutlet weak var outputCoinAmountLabel: UILabel!
    
    var pageHolderVC: StepGenTxViewController!
    var selectedPool: Sifnode_Clp_V1_Pool!
    var swapInDenom = ""
    var swapOutDenom = ""
    var dpInPutDecimal:Int16 = 18
    var dpOutPutDecimal:Int16 = 18
    var swapRate = NSDecimalNumber.one
    var availableMaxAmount = NSDecimalNumber.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.pageHolderVC = self.parent as? StepGenTxViewController
        self.selectedPool = self.pageHolderVC.mSifPool
        self.swapInDenom = self.pageHolderVC.mSwapInDenom!
        self.swapOutDenom = self.pageHolderVC.mSwapOutDenom!
        self.dpInPutDecimal = WUtils.getSifCoinDecimal(swapInDenom)
        self.dpOutPutDecimal = WUtils.getSifCoinDecimal(swapOutDenom)
        
        inputTextFiled.delegate = self
        inputTextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        loadingImg.startAnimating()
        onFetchSifPool(selectedPool.externalAsset.symbol)
    }
    
    override func enableUserInteraction() {
        self.btnCancel.isUserInteractionEnabled = true
        self.btnNext.isUserInteractionEnabled = true
    }
    
    func onInitView() {
        availableMaxAmount = BaseData.instance.getAvailableAmount_gRPC(swapInDenom)
        let txFeeAmount = WUtils.getEstimateGasFeeAmount(chainType!, SIF_MSG_TYPE_SWAP_CION, 0)
        if (swapInDenom == SIF_MAIN_DENOM) {
            availableMaxAmount = availableMaxAmount.subtracting(txFeeAmount)
        }
        WUtils.showCoinDp(swapInDenom, availableMaxAmount.stringValue, inputCoinAvailableDenomLabel, inputCoinAvailableLabel, chainType!)
        WUtils.DpSifCoinImg(inputCoinImg, swapInDenom)
        WUtils.DpSifCoinName(inputCoinName, swapInDenom)
        WUtils.DpSifCoinImg(outputCoinImg, swapOutDenom)
        WUtils.DpSifCoinName(outputCoinName, swapOutDenom)
        
        let lpInputAmount = WUtils.getPoolLpAmount(selectedPool, swapInDenom)
        let lpOutputAmount = WUtils.getPoolLpAmount(selectedPool, swapOutDenom)
        swapRate = lpOutputAmount.dividing(by: lpInputAmount, withBehavior: WUtils.handler24Down).multiplying(byPowerOf10: (dpInPutDecimal - dpOutPutDecimal))
        print("swapRate ", swapRate)
        
        self.loadingImg.stopAnimating()
        self.loadingImg.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if (text.contains(".") && string.contains(".") && range.length == 0) { return false }
        if (text.count == 0 && string.starts(with: ".")) { return false }
        if (text.contains(",") && string.contains(",") && range.length == 0) { return false }
        if (text.count == 0 && string.starts(with: ",")) { return false }
        if let index = text.range(of: ".")?.upperBound {
            if(text.substring(from: index).count > (dpInPutDecimal - 1) && range.length == 0) { return false }
        }
        if let index = text.range(of: ",")?.upperBound {
            if(text.substring(from: index).count > (dpInPutDecimal - 1) && range.length == 0) { return false }
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == inputTextFiled) {
            self.onUIupdate()
        }
    }
    
    func onUIupdate() {
        guard let text = inputTextFiled.text?.trimmingCharacters(in: .whitespaces) else {
            inputTextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            return
        }
        if (text.count == 0) {
            inputTextFiled.layer.borderColor = UIColor.white.cgColor
            return
        }
        
        let userInput = WUtils.localeStringToDecimal(text)
        if (text.count > 1 && userInput == NSDecimalNumber.zero) {
            inputTextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            return
        }
        if (userInput.compare(NSDecimalNumber.init(string: "0.01")).rawValue < 0) {
            inputTextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            return
        }
        if (userInput.multiplying(byPowerOf10: dpInPutDecimal).compare(availableMaxAmount).rawValue > 0) {
            inputTextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            return
        }
        inputTextFiled.layer.borderColor = UIColor.white.cgColor
        
        //slippage
        let padding = NSDecimalNumber(string: "0.98")
        let outputAmount = userInput.multiplying(by: padding, withBehavior: WUtils.handler24Down).multiplying(by: swapRate, withBehavior: WUtils.handler24Down)
        print("outputAmount ", outputAmount)
        
        //lp Fee
        let lpInputAmount = WUtils.getPoolLpAmount(selectedPool, swapInDenom)
        let lpOutputAmount = WUtils.getPoolLpAmount(selectedPool, swapOutDenom)
        let input = userInput.multiplying(byPowerOf10: dpInPutDecimal)
        let numerator = input.multiplying(by: input).multiplying(by: lpOutputAmount)
        let divider = input.adding(lpInputAmount)
        let denominator = divider.multiplying(by: divider)
        let lpFee = numerator.dividing(by: denominator, withBehavior: WUtils.handler0).multiplying(byPowerOf10: -dpOutPutDecimal, withBehavior: WUtils.handler18)
        print("lpFee ", lpFee)
        
        
        outputCoinAmountLabel.text = WUtils.decimalNumberToLocaleString(outputAmount.subtracting(lpFee), dpOutPutDecimal)
        
        
    }
    
    @IBAction func onClickClear(_ sender: UIButton) {
        self.inputTextFiled.text = ""
        self.onUIupdate()
    }
    
    @IBAction func onClick1_4(_ sender: UIButton) {
        let calValue = availableMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -dpInPutDecimal, withBehavior: WUtils.getDivideHandler(dpInPutDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, dpInPutDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClickHalf(_ sender: UIButton) {
        let calValue = availableMaxAmount.dividing(by: NSDecimalNumber(2)).multiplying(byPowerOf10: -dpInPutDecimal, withBehavior: WUtils.getDivideHandler(dpInPutDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, dpInPutDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClick3_4(_ sender: UIButton) {
        let calValue = availableMaxAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -dpInPutDecimal, withBehavior: WUtils.getDivideHandler(dpInPutDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, dpInPutDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClickMax(_ sender: UIButton) {
        let maxValue = availableMaxAmount.multiplying(byPowerOf10: -dpInPutDecimal, withBehavior: WUtils.getDivideHandler(dpInPutDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, dpInPutDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        self.btnCancel.isUserInteractionEnabled = false
        self.btnNext.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
        if (isValiadAmount()) {
            let userInput = WUtils.localeStringToDecimal((inputTextFiled.text?.trimmingCharacters(in: .whitespaces))!)
            pageHolderVC.mSwapInAmount = userInput.multiplying(byPowerOf10: dpInPutDecimal)
            let userOutput = WUtils.localeStringToDecimal((outputCoinAmountLabel.text?.trimmingCharacters(in: .whitespaces))!)
            pageHolderVC.mSwapOutAmount = userOutput.multiplying(byPowerOf10: dpOutPutDecimal)
            pageHolderVC.mSifPool = selectedPool
            sender.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
        }
    }
    
    func isValiadAmount() -> Bool {
        let text = inputTextFiled.text?.trimmingCharacters(in: .whitespaces)
        if (text == nil || text!.count == 0) { return false }
        let userInput = WUtils.localeStringToDecimal(text!)
        if (userInput == NSDecimalNumber.zero) { return false }
        if (userInput.multiplying(byPowerOf10: dpInPutDecimal).compare(availableMaxAmount).rawValue > 0) { return false }
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
