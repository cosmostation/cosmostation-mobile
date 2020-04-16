//
//  StepHtlcSend3ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2020/04/15.
//  Copyright © 2020 wannabit. All rights reserved.
//

import UIKit

class StepHtlcSend3ViewController: BaseViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var sendImg: UIImageView!
    @IBOutlet weak var sendAmountLabel: UILabel!
    @IBOutlet weak var sendAmountDenom: UILabel!
    @IBOutlet weak var sendFeeLabel: UILabel!
    @IBOutlet weak var sendFeeDenom: UILabel!
    @IBOutlet weak var recipientChainLabel: UILabel!
    @IBOutlet weak var recipientAddressLabel: UILabel!
    
    @IBOutlet weak var claimImg: UIImageView!
    @IBOutlet weak var claimFeeLabel: UILabel!
    @IBOutlet weak var claimFeeDenom: UILabel!
    @IBOutlet weak var claimAddress: UILabel!
    
    var pageHolderVC: StepGenTxViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageHolderVC = self.parent as? StepGenTxViewController
    }
    
    override func enableUserInteraction() {
        self.btnBack.isUserInteractionEnabled = true
        self.btnConfirm.isUserInteractionEnabled = true
        self.onUpdateView()
    }
    
    func onUpdateView() {
        onInitSendFee()
        onInitClaimFee()
        
        let toSendAmount = WUtils.stringToDecimalNoLocale(pageHolderVC.mToSendAmount[0].amount)
        let sendFeeAmount = WUtils.stringToDecimalNoLocale((pageHolderVC.mHtlcSendFee?.amount[0].amount)!)
        let claimFeeAmount = WUtils.stringToDecimalNoLocale((pageHolderVC.mHtlcClaimFee?.amount[0].amount)!)
        
        //set Send layer's data
        sendImg.image = sendImg.image?.withRenderingMode(.alwaysTemplate)
        sendImg.tintColor = WUtils.getChainColor(pageHolderVC.chainType!)
        WUtils.setDenomTitle(pageHolderVC.chainType!, sendFeeDenom)
        if (pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_BINANCE_MAIN || pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_BINANCE_TEST) {
            sendAmountDenom.text = self.pageHolderVC.mHtlcDenom!.uppercased()
            sendAmountDenom.textColor = COLOR_BNB
            
            sendAmountLabel.attributedText = WUtils.displayAmount2(toSendAmount.stringValue, sendAmountLabel.font, 0, 8)
            sendFeeLabel.attributedText = WUtils.displayAmount2(sendFeeAmount.stringValue, sendFeeLabel.font, 0, 8)
            
            recipientChainLabel.text = WUtils.getChainName(pageHolderVC.mHtlcToChain!)
            recipientAddressLabel.text = pageHolderVC.mHtlcToAccount?.account_address
            
        } else if (pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_KAVA_MAIN || pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_KAVA_TEST) {
            sendAmountDenom.text = self.pageHolderVC.mHtlcDenom!.uppercased()
            sendAmountDenom.textColor = .white
            
            sendAmountLabel.attributedText = WUtils.displayAmount2(toSendAmount.stringValue, sendAmountLabel.font, 6, 6)
            sendFeeLabel.attributedText = WUtils.displayAmount2(sendFeeAmount.stringValue, sendFeeLabel.font, 6, 6)
            
            recipientChainLabel.text = WUtils.getChainName(pageHolderVC.mHtlcToChain!)
            claimAddress.text = pageHolderVC.mHtlcToAccount?.account_address
            
        }
        
        //set Claim layer's data
        claimImg.image = claimImg.image?.withRenderingMode(.alwaysTemplate)
        claimImg.tintColor = WUtils.getChainColor(pageHolderVC.mHtlcToChain!)
        WUtils.setDenomTitle(pageHolderVC.mHtlcToChain!, claimFeeDenom)
        if (pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_BINANCE_MAIN || pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_BINANCE_TEST) {
            claimFeeLabel.attributedText = WUtils.displayAmount2(claimFeeAmount.stringValue, claimFeeLabel.font, 0, 8)
            recipientAddressLabel.text = pageHolderVC.mHtlcToAccount?.account_address
            
        } else if (pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_KAVA_MAIN || pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_KAVA_TEST) {
            claimFeeLabel.attributedText = WUtils.displayAmount2(claimFeeAmount.stringValue, claimFeeLabel.font, 6, 6)
            claimAddress.text = pageHolderVC.mHtlcToAccount?.account_address
            
        }
    }
    
    
    
    @IBAction func onClickBack(_ sender: UIButton) {
        self.btnBack.isUserInteractionEnabled = false
        self.btnConfirm.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
        
    }
    
    @IBAction func onClickConfirm(_ sender: UIButton) {
        
    }
    
    func onInitSendFee() {
        if (pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_BINANCE_MAIN ||
            pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_BINANCE_TEST) {
            let feeCoin = Coin.init(BNB_MAIN_DENOM, "0.000375")
            var tempList = Array<Coin>()
            tempList.append(feeCoin)
            pageHolderVC.mHtlcSendFee = Fee.init("", tempList)
            
        } else if (pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_KAVA_MAIN ||
            pageHolderVC.chainType! == ChainType.SUPPORT_CHAIN_KAVA_TEST) {
            let feeCoin = Coin.init(KAVA_MAIN_DENOM, "5000")
            var tempList = Array<Coin>()
            tempList.append(feeCoin)
            pageHolderVC.mHtlcSendFee = Fee.init(KAVA_GAS_FEE_AMOUNT_BEP3, tempList)
            
        }
    }
    
    func onInitClaimFee() {
        if (pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_BINANCE_MAIN ||
            pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_BINANCE_TEST) {
            let feeCoin = Coin.init(BNB_MAIN_DENOM, "0.000375")
            var tempList = Array<Coin>()
            tempList.append(feeCoin)
            pageHolderVC.mHtlcClaimFee = Fee.init("", tempList)
            
        } else if (pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_KAVA_MAIN ||
            pageHolderVC.mHtlcToChain == ChainType.SUPPORT_CHAIN_KAVA_TEST) {
            let feeCoin = Coin.init(KAVA_MAIN_DENOM, "5000")
            var tempList = Array<Coin>()
            tempList.append(feeCoin)
            pageHolderVC.mHtlcClaimFee = Fee.init(KAVA_GAS_FEE_AMOUNT_BEP3, tempList)
            
        }
    }
}
