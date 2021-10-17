//
//  SifDexDAppViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/15.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit
import GRPC
import NIO
import SwiftProtobuf

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
        
        self.onFetchSifDexData()
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
    
    var mFetchCnt = 0
    @objc func onFetchSifDexData() -> Bool {
        if (self.mFetchCnt > 0)  {
            return false
        }
        self.mFetchCnt = 2
        BaseData.instance.mSifDexPools_gRPC.removeAll()
        BaseData.instance.mSifDexMyAssets_gRPC.removeAll()
        
        self.onFetchPools()
        self.onFetchMyPoolAssets(self.account!.account_address)
        return true
    }
    
    func onFetchFinished() {
        self.mFetchCnt = self.mFetchCnt - 1
        if (mFetchCnt > 0) { return }
        print("allPools ", BaseData.instance.mSifDexPools_gRPC.count)
        print("myAssets ", BaseData.instance.mSifDexMyAssets_gRPC.count)
        NotificationCenter.default.post(name: Notification.Name("SifDexFetchDone"), object: nil, userInfo: nil)
    }

    
    func onFetchPools() {
        DispatchQueue.global().async {
            do {
                let channel = BaseNetWork.getConnection(self.chainType!, MultiThreadedEventLoopGroup(numberOfThreads: 1))!
                let req = Sifnode_Clp_V1_PoolsReq.init()
                if let response = try? Sifnode_Clp_V1_QueryClient(channel: channel).getPools(req, callOptions: BaseNetWork.getCallOptions()).response.wait() {
                    BaseData.instance.mSifDexPools_gRPC = response.pools
                }
                try channel.close().wait()
                
            } catch {
                print("onFetchPools failed: \(error)")
            }
            DispatchQueue.main.async(execute: { self.onFetchFinished() });
        }
    }
    
    func onFetchMyPoolAssets(_ address: String) {
        DispatchQueue.global().async {
            do {
                let channel = BaseNetWork.getConnection(self.chainType!, MultiThreadedEventLoopGroup(numberOfThreads: 1))!
                let req = Sifnode_Clp_V1_AssetListReq.with { $0.lpAddress = address }
                if let response = try? Sifnode_Clp_V1_QueryClient(channel: channel).getAssetList(req, callOptions: BaseNetWork.getCallOptions()).response.wait() {
                    BaseData.instance.mSifDexMyAssets_gRPC = response.assets
                }
                try channel.close().wait()
                
            } catch {
                print("onFetchMyPools failed: \(error)")
            }
            DispatchQueue.main.async(execute: { self.onFetchFinished() });
        }
    }
}

extension WUtils {
    
    
    
    static func getSifCoinDecimal(_ denom:String?) -> Int16 {
        if (denom?.caseInsensitiveCompare(SIF_MAIN_DENOM) == .orderedSame) { return 18; }
        else if (denom?.caseInsensitiveCompare("cusdt") == .orderedSame) { return 6; }
        else if (denom?.caseInsensitiveCompare("cusdc") == .orderedSame) { return 6; }
        else if (denom?.caseInsensitiveCompare("csrm") == .orderedSame) { return 6; }
        else if (denom?.caseInsensitiveCompare("cwscrt") == .orderedSame) { return 6; }
        else if (denom?.caseInsensitiveCompare("ccro") == .orderedSame) { return 8; }
        else if (denom?.caseInsensitiveCompare("cwbtc") == .orderedSame) { return 8; }
        else if (denom?.caseInsensitiveCompare("xrowan") == .orderedSame) { return 10; }
        else if (denom?.starts(with: "ibc/") == true) {
            if let ibcToken = BaseData.instance.getIbcToken(denom?.replacingOccurrences(of: "ibc/", with: "")), let decimal = ibcToken.decimal  {
                return decimal
            } else {
                return 6
            }
        }
        return 18;
    }
}
