//
//  SifDexSwapViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/15.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifDexSwapViewController: BaseViewController {
    
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
    
//    var mAllDenoms: Array<String> = Array<String>()
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
        
        self.loadingImg.onStopAnimation()
        self.loadingImg.isHidden = true
    }
    
    @objc func onSifDexFetchDone(_ notification: NSNotification) {
        if (BaseData.instance.mSifDexPools_gRPC.count <= 0) {
            self.onShowToast(NSLocalizedString("error_network", comment: ""))
            self.navigationController?.popViewController(animated: true)
            return
        }
        if (mSelectedPool == nil || mInputCoinDenom == nil || mOutputCoinDenom == nil) {
            mSelectedPool = BaseData.instance.mSifDexPools_gRPC[0]
            mInputCoinDenom = WUtils.getMainDenom(chainType)
            mOutputCoinDenom = mSelectedPool?.externalAsset.symbol
        }
        self.updateView()
    }

    
    @IBAction func onClickToggle(_ sender: UIButton) {
    }
    
    @IBAction func onClickStarSwap(_ sender: UIButton) {
    }
}
