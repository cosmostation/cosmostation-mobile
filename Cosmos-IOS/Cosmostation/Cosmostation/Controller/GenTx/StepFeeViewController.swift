//
//  StepDelegateFeeViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 08/04/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit

class StepFeeViewController: BaseViewController {

    @IBOutlet weak var feeTypeCardView: CardView!
    @IBOutlet weak var feeTypeDenomLabel: UILabel!
    @IBOutlet weak var minFeeCardView: CardView!
    @IBOutlet weak var minFeeAmountLabel: UILabel!
    @IBOutlet weak var minFeePriceLabel: UILabel!
    @IBOutlet weak var rateFeeCardView: CardView!
    @IBOutlet weak var rateFeeGasAmountLabel: UILabel!
    @IBOutlet weak var rateFeeGasRateLabel: UILabel!
    @IBOutlet weak var rateFeeAmountLabel: UILabel!
    @IBOutlet weak var rateFeePriceLabel: UILabel!
    @IBOutlet weak var feeSlider: UISlider!
    @IBOutlet weak var feesLabels: UIStackView!
    @IBOutlet weak var speedImg: UIImageView!
    @IBOutlet weak var speedMsg: UILabel!
    
    
    @IBOutlet weak var beforeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var pageHolderVC: StepGenTxViewController!
    var feeAmount   = NSDecimalNumber.zero
    var feeCoin:Coin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageHolderVC = self.parent as? StepGenTxViewController
        WUtils.setDenomTitle(pageHolderVC.chainType!, feeTypeDenomLabel)
        feeSlider.tintColor = WUtils.getChainColor(pageHolderVC.chainType!)
        
        if (pageHolderVC.chainType! == ChainType.KAVA_MAIN || pageHolderVC.chainType! == ChainType.KAVA_TEST || pageHolderVC.chainType! == ChainType.BAND_MAIN) {
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.tapFeeType(sender:)))
            self.feeTypeCardView.addGestureRecognizer(gesture)
            
            _ = updateView(0)
            self.speedImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap (_:))))
            self.speedImg.isUserInteractionEnabled = true
            
        } else if (pageHolderVC.chainType! == ChainType.BINANCE_MAIN || pageHolderVC.chainType! == ChainType.BINANCE_TEST) {
            self.minFeeCardView.isHidden = false
            self.rateFeeCardView.isHidden = true
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_bnb_title", comment: "")
            
            feeAmount = WUtils.plainStringToDecimal(GAS_FEE_BNB_TRANSFER)
            self.minFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, minFeeAmountLabel.font, 0, 8)
            self.minFeePriceLabel.attributedText  = WUtils.dpBnbValue(feeAmount, BaseData.instance.getLastPrice(), minFeePriceLabel.font)
            
        } else if (pageHolderVC.chainType! == ChainType.IOV_MAIN || pageHolderVC.chainType! == ChainType.IOV_TEST) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_iov_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: IOV_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 2)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 6, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpAtomValue(feeAmount, BaseData.instance.getLastPrice(), rateFeePriceLabel.font)
            
        } else if (pageHolderVC.chainType! == ChainType.OKEX_MAIN || pageHolderVC.chainType! == ChainType.OKEX_TEST) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_ok_title", comment: "")
            
            var estimateGasAmount = NSDecimalNumber.zero
            if (pageHolderVC.mType == OK_MSG_TYPE_DEPOSIT || pageHolderVC.mType == OK_MSG_TYPE_WITHDRAW) {
                var currentVotedCnt = 0
                if let voted = BaseData.instance.mOkStaking?.validator_address?.count { currentVotedCnt = voted }
                estimateGasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, currentVotedCnt)
            } else {
                estimateGasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mOkVoteValidators.count)
            }
            let gasRate = NSDecimalNumber.init(string: GAS_FEE_RATE_OK)
            self.rateFeeGasAmountLabel.text = estimateGasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 8)
            feeAmount = estimateGasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler8)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 0, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpTokenValue(feeAmount, BaseData.instance.getLastPrice(), 0, self.rateFeePriceLabel.font)
            
            
        } else if (pageHolderVC.chainType! == ChainType.CERTIK_MAIN || pageHolderVC.chainType! == ChainType.CERTIK_TEST) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_certik_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: CERTIK_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 2)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 6, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpAtomValue(feeAmount, BaseData.instance.getLastPrice(), rateFeePriceLabel.font)
            
        } else if (pageHolderVC.chainType! == ChainType.SECRET_MAIN) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_secret_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: SECRET_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 2)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 6, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpAtomValue(feeAmount, BaseData.instance.getLastPrice(), rateFeePriceLabel.font)
            
        }else if (pageHolderVC.chainType! == ChainType.SENTINEL_MAIN) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_sentinel_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: SENTINEL_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 1)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 6, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpTokenValue(feeAmount, BaseData.instance.getLastPrice(), 6, rateFeePriceLabel.font)
            
        } else if (pageHolderVC.chainType! == ChainType.FETCH_MAIN){
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_fetch_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: FETCH_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 2)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 18, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpTokenValue(feeAmount, BaseData.instance.getLastPrice(), 18, rateFeePriceLabel.font)
            
        } else if (pageHolderVC.chainType! == ChainType.SIF_MAIN) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_sif_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: SIF_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 2)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler18)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 18, 18)
            self.rateFeePriceLabel.attributedText = WUtils.dpTokenValue(feeAmount, BaseData.instance.getLastPrice(), 18, rateFeePriceLabel.font)
            
        } else if (pageHolderVC.chainType! == ChainType.KI_MAIN) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            
            self.feeSlider.isHidden = true
            self.feesLabels.isHidden = true
            
            self.speedImg.image = UIImage.init(named: "feeImg")
            self.speedMsg.text = NSLocalizedString("fee_speed_ki_title", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: KI_GAS_FEE_RATE_AVERAGE)
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 3)
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, rateFeeAmountLabel.font, 6, 6)
            self.rateFeePriceLabel.attributedText = WUtils.dpTokenValue(feeAmount, BaseData.instance.getLastPrice(), 6, rateFeePriceLabel.font)
            
        }
        
    }
    
    @objc func imageTap (_ sender: UITapGestureRecognizer) {
        var titleGas = ""
        var msgGas = ""
        if(feeSlider.value == 0) {
            titleGas = NSLocalizedString("fee_description_title_0", comment: "")
            msgGas = NSLocalizedString("fee_description_msg_0", comment: "")
            
        } else if (feeSlider.value == 1) {
            titleGas = NSLocalizedString("fee_description_title_1", comment: "")
            msgGas = NSLocalizedString("fee_description_msg_1", comment: "")
            
        } else {
            titleGas = NSLocalizedString("fee_description_title_2", comment: "")
            msgGas = NSLocalizedString("fee_description_msg_2", comment: "")
            
        }
        
        let noticeAlert = UIAlertController(title: titleGas, message: msgGas, preferredStyle: .alert)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        let attributedMessage: NSMutableAttributedString = NSMutableAttributedString(
            string: msgGas,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)
            ]
        )
        noticeAlert.setValue(attributedMessage, forKey: "attributedMessage")
        noticeAlert.addAction(UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .default, handler: { [weak noticeAlert] (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(noticeAlert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            noticeAlert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }

    @IBAction func onSlideChanged(_ sender: UISlider) {
    }
    
    @IBAction func onSlideEnd(_ sender: UISlider) {
        if (sender.value < 0.5) {
            sender.value = 0.0
            _ = updateView(0)
        } else if (sender.value < 1.5) {
            sender.value = 1.0
            _ = updateView(1)
        } else {
            sender.value = 2.0
            _ = updateView(2)
        }
        
    }
    
    @objc func tapFeeType(sender : UITapGestureRecognizer) {
        self.onShowToast(NSLocalizedString("error_only_fee_with_atom", comment: ""))
    }
    
    @IBAction func onClickBefore(_ sender: Any) {
        self.beforeBtn.isUserInteractionEnabled = false
        self.nextBtn.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
    }
    
    func updateView(_ position: Int) -> Bool {
        var available   = NSDecimalNumber.zero
        var toSpend     = NSDecimalNumber.zero
        feeAmount       = NSDecimalNumber.zero
        
        if (position == 0) {
            self.minFeeCardView.isHidden = false
            self.rateFeeCardView.isHidden = true
            self.speedImg.image = UIImage.init(named: "bycicle")
            self.speedMsg.text = NSLocalizedString("fee_speed_title_0", comment: "")
            
            feeAmount = NSDecimalNumber.zero
            self.minFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, minFeeAmountLabel.font, 6, 6)
            
        } else if (position == 1) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            self.speedImg.image = UIImage.init(named: "car")
            self.speedMsg.text = NSLocalizedString("fee_speed_title_1", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: String(GAS_FEE_RATE_LOW))
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 4)

            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, minFeeAmountLabel.font, 6, 6)
            
        } else if (position == 2) {
            self.minFeeCardView.isHidden = true
            self.rateFeeCardView.isHidden = false
            self.speedImg.image = UIImage.init(named: "roket")
            self.speedMsg.text = NSLocalizedString("fee_speed_title_2", comment: "")
            
            let gasAmount = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count)
            let gasRate = NSDecimalNumber.init(string: String(GAS_FEE_RATE_AVERAGE))
            self.rateFeeGasAmountLabel.text = gasAmount.stringValue
            self.rateFeeGasRateLabel.attributedText = WUtils.displayGasRate(gasRate, font: rateFeeGasRateLabel.font, 3)
            
            feeAmount = gasAmount.multiplying(by: gasRate, withBehavior: WUtils.handler6)
            self.rateFeeAmountLabel.attributedText = WUtils.displayAmount2(feeAmount.stringValue, minFeeAmountLabel.font, 6, 6)
        }
        
        if (pageHolderVC.chainType! == ChainType.KAVA_MAIN || pageHolderVC.chainType! == ChainType.KAVA_TEST) {
            available = WUtils.getTokenAmount(pageHolderVC.mBalances, KAVA_MAIN_DENOM);
            toSpend = getSpendAmount()
            if (pageHolderVC.mKavaSendDenom == KAVA_MAIN_DENOM || pageHolderVC.mHardPoolDenom == KAVA_MAIN_DENOM) {
                if (toSpend.adding(feeAmount).compare(available).rawValue > 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    self.feeSlider.setValue(0, animated: true)
                    self.updateView(0)
                    return false
                }
            } else {
                if(feeAmount.compare(available).rawValue > 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    self.feeSlider.setValue(0, animated: true)
                    self.updateView(0)
                    return false
                }
            }
            
        } else if (pageHolderVC.chainType! == ChainType.BAND_MAIN) {
            available = WUtils.getTokenAmount(pageHolderVC.mBalances, BAND_MAIN_DENOM);
            toSpend = getSpendAmount()
            if (toSpend.adding(feeAmount).compare(available).rawValue > 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                self.feeSlider.setValue(0, animated: true)
                self.updateView(0)
                return false
            }
            
        }
        self.minFeePriceLabel.attributedText = WUtils.dpAtomValue(feeAmount, BaseData.instance.getLastPrice(), minFeePriceLabel.font)
        self.rateFeePriceLabel.attributedText = WUtils.dpAtomValue(feeAmount, BaseData.instance.getLastPrice(), rateFeePriceLabel.font)
        return true;
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if (pageHolderVC.chainType! == ChainType.BINANCE_MAIN || pageHolderVC.chainType! == ChainType.BINANCE_TEST) {
            //Notice! useless but make format!
            feeCoin = Coin.init(BNB_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.KAVA_MAIN || pageHolderVC.chainType! == ChainType.KAVA_TEST) {
            if (self.updateView(Int(feeSlider!.value))) {
                feeCoin = Coin.init(KAVA_MAIN_DENOM, feeAmount.stringValue)
                var fee = Fee.init()
                let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
                fee.gas = estGas
                
                var estAmount: Array<Coin> = Array<Coin>()
                estAmount.append(feeCoin)
                fee.amount = estAmount
                
                pageHolderVC.mFee = fee
                
                self.beforeBtn.isUserInteractionEnabled = false
                self.nextBtn.isUserInteractionEnabled = false
                pageHolderVC.onNextPage()
            }
        } else if (pageHolderVC.chainType! == ChainType.IOV_MAIN) {
            feeCoin = Coin.init(IOV_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.BAND_MAIN) {
            if (NSDecimalNumber.init(string: "100000").compare(feeAmount).rawValue < 0) {return}
            if (self.updateView(Int(feeSlider!.value))) {
                feeCoin = Coin.init(BAND_MAIN_DENOM, feeAmount.stringValue)
                var fee = Fee.init()
                let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
                fee.gas = estGas
                
                var estAmount: Array<Coin> = Array<Coin>()
                estAmount.append(feeCoin)
                fee.amount = estAmount
                
                pageHolderVC.mFee = fee
                
                self.beforeBtn.isUserInteractionEnabled = false
                self.nextBtn.isUserInteractionEnabled = false
                pageHolderVC.onNextPage()
            }
        } else if (pageHolderVC.chainType! == ChainType.SECRET_MAIN) {
            feeCoin = Coin.init(SECRET_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.IOV_TEST) {
            feeCoin = Coin.init(IOV_TEST_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.OKEX_MAIN || pageHolderVC.chainType! == ChainType.OKEX_TEST) {
            feeCoin = Coin.init(OKEX_MAIN_DENOM, WUtils.getFormattedNumber(feeAmount, 18))
            var fee = Fee.init()
            var estimateGas = ""
            if (pageHolderVC.mType == OK_MSG_TYPE_DEPOSIT || pageHolderVC.mType == OK_MSG_TYPE_WITHDRAW) {
                var currentVotedCnt = 0
                if let voted = BaseData.instance.mOkStaking?.validator_address?.count { currentVotedCnt = voted }
                estimateGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, currentVotedCnt).stringValue
            } else {
                estimateGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mOkVoteValidators.count).stringValue
            }
            fee.gas = estimateGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            pageHolderVC.mFee = fee

            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.CERTIK_MAIN || pageHolderVC.chainType! == ChainType.CERTIK_TEST) {
            feeCoin = Coin.init(CERTIK_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.SENTINEL_MAIN) {
            feeCoin = Coin.init(SENTINEL_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.FETCH_MAIN) {
            feeCoin = Coin.init(FETCH_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.SIF_MAIN) {
            feeCoin = Coin.init(SIF_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        } else if (pageHolderVC.chainType! == ChainType.KI_MAIN) {
            feeCoin = Coin.init(KI_MAIN_DENOM, feeAmount.stringValue)
            var fee = Fee.init()
            let estGas = WUtils.getEstimateGasAmount(pageHolderVC.chainType!, pageHolderVC.mType!, pageHolderVC.mRewardTargetValidators.count).stringValue
            fee.gas = estGas
            
            var estAmount: Array<Coin> = Array<Coin>()
            estAmount.append(feeCoin)
            fee.amount = estAmount
            
            pageHolderVC.mFee = fee
            
            self.beforeBtn.isUserInteractionEnabled = false
            self.nextBtn.isUserInteractionEnabled = false
            pageHolderVC.onNextPage()
            
        }
    }
    
    override func enableUserInteraction() {
        self.beforeBtn.isUserInteractionEnabled = true
        self.nextBtn.isUserInteractionEnabled = true
    }
 
    func getSpendAmount() -> NSDecimalNumber {
        var result = NSDecimalNumber.zero
        if (pageHolderVC.mType == COSMOS_MSG_TYPE_DELEGATE) {
            result = WUtils.localeStringToDecimal(pageHolderVC.mToDelegateAmount!.amount)
            
        } else if (pageHolderVC.mType == COSMOS_MSG_TYPE_UNDELEGATE2) {
        } else if (pageHolderVC.mType == COSMOS_MSG_TYPE_TRANSFER2 || pageHolderVC.mType == KAVA_MSG_TYPE_TRANSFER || pageHolderVC.mType == BAND_MSG_TYPE_TRANSFER ||
                    pageHolderVC.mType == IOV_MSG_TYPE_TRANSFER || pageHolderVC.mType == SECRET_MSG_TYPE_TRANSFER || pageHolderVC.mType == OK_MSG_TYPE_TRANSFER ||
                    pageHolderVC.mType == CERTIK_MSG_TYPE_TRANSFER) {
            result = WUtils.localeStringToDecimal(pageHolderVC.mToSendAmount[0].amount)
            
        } else if (pageHolderVC.mType == COSMOS_MSG_TYPE_WITHDRAW_DEL) {
        } else if(pageHolderVC.mType == COSMOS_MSG_TYPE_REDELEGATE2) {
        } else if(pageHolderVC.mType == COSMOS_MSG_TYPE_WITHDRAW_MIDIFY) {
        } else if(pageHolderVC.mType == KAVA_MSG_TYPE_DEPOSIT_HAVEST) {
            result = WUtils.localeStringToDecimal(pageHolderVC.mHardPoolCoin.amount)
        }
        return result

    }
}
