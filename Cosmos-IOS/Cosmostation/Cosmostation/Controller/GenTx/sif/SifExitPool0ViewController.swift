//
//  SifExitPool0ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/19.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit
import GRPC
import NIO
import SwiftProtobuf

class SifExitPool0ViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var loadingImg: LoadingImageView!
    @IBOutlet weak var lpAvailableLabel: UILabel!
    @IBOutlet weak var inputTextFiled: AmountInputTextField!
    
    var pageHolderVC: StepGenTxViewController!
    var selectedPool: Sifnode_Clp_V1_Pool!
    var myProvider: Sifnode_Clp_V1_LiquidityProviderRes!
    var unitAmount = NSDecimalNumber.zero
    var unitDecimal:Int16 = 18

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.pageHolderVC = self.parent as? StepGenTxViewController
        self.selectedPool = self.pageHolderVC.mSifPool
        
        inputTextFiled.delegate = self
        inputTextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        loadingImg.startAnimating()
        onFetchMyProviderInfo(account!.account_address, selectedPool.externalAsset.symbol)
    }
    
    override func enableUserInteraction() {
        self.btnCancel.isUserInteractionEnabled = true
        self.btnNext.isUserInteractionEnabled = true
    }
    
    func onInitView() {
        unitAmount = NSDecimalNumber.init(string: myProvider.liquidityProvider.liquidityProviderUnits)
        lpAvailableLabel.attributedText = WUtils.displayAmount2(unitAmount.stringValue, lpAvailableLabel.font, unitDecimal, unitDecimal)
        
        self.loadingImg.stopAnimating()
        self.loadingImg.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if (text.contains(".") && string.contains(".") && range.length == 0) { return false }
        if (text.count == 0 && string.starts(with: ".")) { return false }
        if (text.contains(",") && string.contains(",") && range.length == 0) { return false }
        if (text.count == 0 && string.starts(with: ",")) { return false }
        if (textField == inputTextFiled) {
            if let index = text.range(of: ".")?.upperBound {
                if(text.substring(from: index).count > (unitDecimal - 1) && range.length == 0) { return false }
            }
            if let index = text.range(of: ",")?.upperBound {
                if(text.substring(from: index).count > (unitDecimal - 1) && range.length == 0) { return false }
            }
            
        } else if (textField == inputTextFiled) {
            if let index = text.range(of: ".")?.upperBound {
                if(text.substring(from: index).count > (unitDecimal - 1) && range.length == 0) { return false }
            }
            if let index = text.range(of: ",")?.upperBound {
                if(text.substring(from: index).count > (unitDecimal - 1) && range.length == 0) { return false }
            }
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
        if (userInput.compare(NSDecimalNumber.zero).rawValue <= 0) {
            inputTextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            return
        }
        if (userInput.multiplying(byPowerOf10: unitDecimal).compare(unitAmount).rawValue > 0) {
            inputTextFiled.layer.borderColor = UIColor.init(hexString: "f31963").cgColor
            return
        }
        inputTextFiled.layer.borderColor = UIColor.white.cgColor
    }
    
    
    @IBAction func onClickClear(_ sender: UIButton) {
        self.inputTextFiled.text = ""
        self.onUIupdate()
    }
    
    @IBAction func onClick1_4(_ sender: UIButton) {
        let calValue = unitAmount.multiplying(by: NSDecimalNumber.init(string: "0.25")).multiplying(byPowerOf10: -unitDecimal, withBehavior: WUtils.getDivideHandler(unitDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, unitDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClickHalf(_ sender: UIButton) {
        let calValue = unitAmount.multiplying(by: NSDecimalNumber.init(string: "0.5")).multiplying(byPowerOf10: -unitDecimal, withBehavior: WUtils.getDivideHandler(unitDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, unitDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClick3_4(_ sender: UIButton) {
        let calValue = unitAmount.multiplying(by: NSDecimalNumber.init(string: "0.75")).multiplying(byPowerOf10: -unitDecimal, withBehavior: WUtils.getDivideHandler(unitDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(calValue, unitDecimal)
        self.onUIupdate()
    }
    
    @IBAction func onClickMax(_ sender: UIButton) {
        let maxValue = unitAmount.multiplying(byPowerOf10: -unitDecimal, withBehavior: WUtils.getDivideHandler(unitDecimal))
        inputTextFiled.text = WUtils.decimalNumberToLocaleString(maxValue, unitDecimal)
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
            let userWithdrawAmount = userInput.multiplying(byPowerOf10: unitDecimal)
            pageHolderVC.mSifMyAllUnitAmount = unitAmount.stringValue
            pageHolderVC.mSifMyWithdrawUnitAmount = userWithdrawAmount.stringValue
            
            sender.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else {
            self.onShowToast(NSLocalizedString("error_amount", comment: ""))
        }
    }
    
    func isValiadAmount() -> Bool {
        let text = inputTextFiled.text?.trimmingCharacters(in: .whitespaces)
        if (text == nil || text!.count == 0) { return false }
        let userInput = WUtils.localeStringToDecimal(text!)
        if (userInput == NSDecimalNumber.zero) { return false }
        if (userInput.compare(NSDecimalNumber.zero).rawValue < 0) { return false }
        if (userInput.multiplying(byPowerOf10: unitDecimal).compare(unitAmount).rawValue > 0) { return false }
        return true
    }

    
    func onFetchMyProviderInfo(_ address: String, _ denom: String) {
        DispatchQueue.global().async {
            do {
                let channel = BaseNetWork.getConnection(self.chainType!, MultiThreadedEventLoopGroup(numberOfThreads: 1))!
                let req = Sifnode_Clp_V1_LiquidityProviderReq.with { $0.lpAddress = address; $0.symbol = denom }
                if let response = try? Sifnode_Clp_V1_QueryClient(channel: channel).getLiquidityProvider(req, callOptions: BaseNetWork.getCallOptions()).response.wait() {
                    self.myProvider = response
                }
                try channel.close().wait()
                
            } catch {
                print("onFetchMyProviderInfo failed: \(error)")
            }
            DispatchQueue.main.async(execute: { self.onInitView() });
        }
    }
}
