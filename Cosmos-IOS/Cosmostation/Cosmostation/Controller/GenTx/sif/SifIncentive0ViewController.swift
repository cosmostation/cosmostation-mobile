//
//  SifIncentive0ViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/17.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifIncentive0ViewController: BaseViewController {
    
    @IBOutlet weak var btnLink: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var sifIncentiveAmountLabel: UILabel!
    @IBOutlet weak var sifIncentiveDenomLabel: UILabel!
    @IBOutlet weak var sifIncentiveTypeLabel: UILabel!
    
    var pageHolderVC: StepGenTxViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.pageHolderVC = self.parent as? StepGenTxViewController
        
        let lmCurrentAmount = BaseData.instance.mSifLmIncentive?.user?.totalClaimableCommissionsAndClaimableRewards
        sifIncentiveAmountLabel.attributedText = WUtils.displayAmount2(String(lmCurrentAmount!), sifIncentiveAmountLabel.font, 0, 6)
        sifIncentiveTypeLabel.text = "liquidityMining"
    }
    
    override func enableUserInteraction() {
        self.btnLink.isUserInteractionEnabled = true
        self.btnCancel.isUserInteractionEnabled = true
        self.btnNext.isUserInteractionEnabled = true
    }
    
    @IBAction func onClickLink(_ sender: UIButton) {
        guard let url = URL(string: "https://docs.sifchain.finance/resources/rewards-programs#special-programs") else { return }
        self.onShowSafariWeb(url)
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        self.btnLink.isUserInteractionEnabled = false
        self.btnCancel.isUserInteractionEnabled = false
        self.btnNext.isUserInteractionEnabled = false
        pageHolderVC.onBeforePage()
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
        self.btnLink.isUserInteractionEnabled = false
        self.btnCancel.isUserInteractionEnabled = false
        self.btnNext.isUserInteractionEnabled = false
        pageHolderVC.onNextPage()
    }
}
