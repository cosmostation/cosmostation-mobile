//
//  SifDexDAppViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/15.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class SifDexDAppViewController: BaseViewController {
    
    @IBOutlet weak var dAppsSegment: UISegmentedControl!
    @IBOutlet weak var swapView: UIView!
    @IBOutlet weak var ethPoolView: UIView!
    @IBOutlet weak var ibcPoolView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        swapView.alpha = 1
        ethPoolView.alpha = 0
        ibcPoolView.alpha = 0
        
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        
        if #available(iOS 13.0, *) {
            dAppsSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            dAppsSegment.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
            dAppsSegment.selectedSegmentTintColor = TRANS_BG_COLOR_SIF2
        } else {
            dAppsSegment.tintColor = COLOR_SIF
        }
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            swapView.alpha = 1
            ethPoolView.alpha = 0
            ibcPoolView.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            swapView.alpha = 0
            ethPoolView.alpha = 1
            ibcPoolView.alpha = 0
        } else if sender.selectedSegmentIndex == 2 {
            swapView.alpha = 0
            ethPoolView.alpha = 0
            ibcPoolView.alpha = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_sif_dex", comment: "");
        self.navigationItem.title = NSLocalizedString("title_sif_dex", comment: "");
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

}
