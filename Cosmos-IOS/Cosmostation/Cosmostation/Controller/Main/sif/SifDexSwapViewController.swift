//
//  SifDexSwapViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/15.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifDexSwapViewController: BaseViewController, SBCardPopupDelegate {
    
    @IBOutlet weak var loadingImg: LoadingImageView!
    
    @IBOutlet weak var inputCoinLayer: CardView!
    @IBOutlet weak var inputCoinImg: UIImageView!
    @IBOutlet weak var inputCoinName: UILabel!
    @IBOutlet weak var inputCoinAvailableAmountLabel: UILabel!
    
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var swapFeeLabel: UILabel!
    @IBOutlet weak var slippageLabel: UILabel!
    
    @IBOutlet weak var outputCoinLayer: CardView!
    @IBOutlet weak var outputCoinImg: UIImageView!
    @IBOutlet weak var outputCoinName: UILabel!
    
    @IBOutlet weak var inputCoinRateAmount: UILabel!
    @IBOutlet weak var inputCoinRateDenom: UILabel!
    @IBOutlet weak var outputCoinRateAmount: UILabel!
    @IBOutlet weak var outputCoinRateDenom: UILabel!
    @IBOutlet weak var inputCoinExRateAmount: UILabel!
    @IBOutlet weak var inputCoinExRateDenom: UILabel!
    @IBOutlet weak var outputCoinExRateAmount: UILabel!
    @IBOutlet weak var outputCoinExRateDenom: UILabel!
    
    var mAllDenoms: Array<String> = Array<String>()
    var mSwapableDenoms: Array<String> = Array<String>()
    var mSelectedPool: Sifnode_Clp_V1_Pool?
    var mInputCoinDenom: String?
    var mOutputCoinDenom: String?
    var mInPutDecimal:Int16 = 6
    var mOutPutDecimal:Int16 = 6
    var mAvailableMaxAmount = NSDecimalNumber.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.loadingImg.onStartAnimation()
        
        self.inputCoinLayer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickInput (_:))))
        self.outputCoinLayer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickOutput (_:))))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSifDexFetchDone(_:)), name: Notification.Name("SifDexFetchDone"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("SifDexFetchDone"), object: nil)
    }
    
    func updateView() {
        mInPutDecimal = WUtils.getSifCoinDecimal(mInputCoinDenom!)
        mOutPutDecimal = WUtils.getSifCoinDecimal(mOutputCoinDenom!)
        mAvailableMaxAmount = BaseData.instance.getAvailableAmount_gRPC(mInputCoinDenom!)
        
        self.slippageLabel.attributedText = WUtils.displayPercent(NSDecimalNumber.init(string: "2"), swapFeeLabel.font)
        self.inputCoinAvailableAmountLabel.attributedText = WUtils.displayAmount2(mAvailableMaxAmount.stringValue, inputCoinAvailableAmountLabel.font!, mInPutDecimal, mInPutDecimal)
        
        WUtils.DpSifCoinImg(inputCoinImg, mInputCoinDenom!)
        WUtils.DpSifCoinName(inputCoinName, mInputCoinDenom!)
        WUtils.DpSifCoinName(inputCoinRateDenom, mInputCoinDenom!)
        WUtils.DpSifCoinName(inputCoinExRateDenom, mInputCoinDenom!)
        WUtils.DpSifCoinImg(outputCoinImg, mOutputCoinDenom!)
        WUtils.DpSifCoinName(outputCoinName, mOutputCoinDenom!)
        WUtils.DpSifCoinName(outputCoinRateDenom, mOutputCoinDenom!)
        WUtils.DpSifCoinName(outputCoinExRateDenom, mOutputCoinDenom!)
        
        self.inputCoinRateAmount.attributedText = WUtils.displayAmount2(NSDecimalNumber.one.stringValue, inputCoinRateAmount.font, 0, 6)
        self.inputCoinExRateAmount.attributedText = WUtils.displayAmount2(NSDecimalNumber.one.stringValue, inputCoinExRateAmount.font, 0, 6)
        
        //display swap rate with this pool
        let lpInputAmount = WUtils.getPoolLpAmount(mSelectedPool!, mInputCoinDenom!)
        let lpOutputAmount = WUtils.getPoolLpAmount(mSelectedPool!, mOutputCoinDenom!)
        let poolSwapRate = lpOutputAmount.dividing(by: lpInputAmount, withBehavior: WUtils.handler24Down).multiplying(byPowerOf10: (mInPutDecimal - mOutPutDecimal))
        self.outputCoinRateAmount.attributedText = WUtils.displayAmount2(poolSwapRate.stringValue, outputCoinRateAmount.font, 0, 6)
        
        //display swap rate with market price
        let priceInput = WUtils.perUsdValue(WUtils.getBaseDenom(mInputCoinDenom!)) ?? NSDecimalNumber.zero
        let priceOutput = WUtils.perUsdValue(WUtils.getBaseDenom(mOutputCoinDenom!)) ?? NSDecimalNumber.zero
        if (priceInput == NSDecimalNumber.zero || priceOutput == NSDecimalNumber.zero) {
            self.outputCoinExRateAmount.text = "?.??????"
        } else {
            let priceRate = priceInput.dividing(by: priceOutput, withBehavior: WUtils.handler6)
            self.outputCoinExRateAmount.attributedText = WUtils.displayAmount2(priceRate.stringValue, outputCoinExRateAmount.font, 0, 6)
        }
        
        self.loadingImg.onStopAnimation()
        self.loadingImg.isHidden = true
    }
    
    @objc func onSifDexFetchDone(_ notification: NSNotification) {
        if (BaseData.instance.mSifDexPools_gRPC.count <= 0) {
            self.onShowToast(NSLocalizedString("error_network", comment: ""))
            self.navigationController?.popViewController(animated: true)
            return
        }
        mAllDenoms.append(SIF_MAIN_DENOM)
        BaseData.instance.mSifDexPools_gRPC.forEach { pool in
            mAllDenoms.append(pool.externalAsset.symbol)
        }
        if (mSelectedPool == nil || mInputCoinDenom == nil || mOutputCoinDenom == nil) {
            mSelectedPool = BaseData.instance.mSifDexPools_gRPC[0]
            mInputCoinDenom = WUtils.getMainDenom(chainType)
            mOutputCoinDenom = mSelectedPool?.externalAsset.symbol
        }
        self.updateView()
    }

    
    @IBAction func onClickToggle(_ sender: UIButton) {
        let temp = mInputCoinDenom
        mInputCoinDenom = mOutputCoinDenom
        mOutputCoinDenom = temp
        self.updateView()
    }
    
    @objc func onClickInput (_ sender: UITapGestureRecognizer) {
        let popupVC = SelectPopupViewController(nibName: "SelectPopupViewController", bundle: nil)
        popupVC.type = SELECT_POPUP_SIF_SWAP_IN
        popupVC.toCoinList = mAllDenoms
        let cardPopup = SBCardPopupViewController(contentViewController: popupVC)
        cardPopup.resultDelegate = self
        cardPopup.show(onViewController: self)
    }
    
    @objc func onClickOutput(_ sender: UIButton) {
        mSwapableDenoms.removeAll()
        if (mInputCoinDenom == SIF_MAIN_DENOM) {
            mSwapableDenoms = mAllDenoms
        } else {
            mSwapableDenoms.append(SIF_MAIN_DENOM)
        }
        
        let popupVC = SelectPopupViewController(nibName: "SelectPopupViewController", bundle: nil)
        popupVC.type = SELECT_POPUP_SIF_SWAP_OUT
        popupVC.toCoinList = mSwapableDenoms
        let cardPopup = SBCardPopupViewController(contentViewController: popupVC)
        cardPopup.resultDelegate = self
        cardPopup.show(onViewController: self)
    }
    
    func SBCardPopupResponse(type: Int, result: Int) {
        if (type == SELECT_POPUP_SIF_SWAP_IN) {
            self.mInputCoinDenom = self.mAllDenoms[result]
            if (mInputCoinDenom == SIF_MAIN_DENOM) {
                mSelectedPool = BaseData.instance.mSifDexPools_gRPC[0]
                mOutputCoinDenom = mSelectedPool?.externalAsset.symbol
            } else {
                mSelectedPool = BaseData.instance.mSifDexPools_gRPC.filter { $0.externalAsset.symbol == mInputCoinDenom }.first
                mOutputCoinDenom = SIF_MAIN_DENOM
            }
            self.updateView()
            
        } else if (type == SELECT_POPUP_SIF_SWAP_OUT) {
            mOutputCoinDenom = self.mSwapableDenoms[result]
            if (mOutputCoinDenom == SIF_MAIN_DENOM) {
                mSelectedPool = BaseData.instance.mSifDexPools_gRPC[0]
                mInputCoinDenom = mSelectedPool?.externalAsset.symbol
            } else {
                mSelectedPool = BaseData.instance.mSifDexPools_gRPC.filter { $0.externalAsset.symbol == mOutputCoinDenom }.first
            }
            self.updateView()
        }
    }
    
    @IBAction func onClickStarSwap(_ sender: UIButton) {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        
        let txFeeAmount = WUtils.getEstimateGasFeeAmount(chainType!, SIF_GAS_AMOUNT_SWAP, 0)
        let mainBalance = BaseData.instance.getAvailableAmount_gRPC(SIF_MAIN_DENOM)
        if (mainBalance.compare(txFeeAmount).rawValue < 0) {
            self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
            return
        }
        
        let inputBalance = BaseData.instance.getAvailableAmount_gRPC(mInputCoinDenom!)
        if (inputBalance.compare(NSDecimalNumber.zero).rawValue <= 0) {
            self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
            return
        }
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        txVC.mType = SIF_MSG_TYPE_SWAP_CION
        txVC.mSifPool = mSelectedPool
        txVC.mSwapInDenom = mInputCoinDenom
        txVC.mSwapOutDenom = mOutputCoinDenom
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
    }
}
