//
//  SifDexEthPoolViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/15.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit
import GRPC
import NIO
import SwiftProtobuf

class SifDexEthPoolViewController: BaseViewController, UITableViewDataSource{
    
    @IBOutlet weak var loadingImg: LoadingImageView!
    @IBOutlet weak var poolListTableView: UITableView!
    
    var mMyEthAssets = Array<String>()
    var mMyEthLps = Array<Sifnode_Clp_V1_LiquidityProviderRes>()
    var mMyEthPools = Array<Sifnode_Clp_V1_Pool>()
    var mOtherEthPools = Array<Sifnode_Clp_V1_Pool>()
    
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
        self.poolListTableView.reloadData()
        self.loadingImg.onStopAnimation()
        self.loadingImg.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier:"CommonMyPoolCell") as? CommonMyPoolCell
            return cell!
    }
    
    
    @objc func onSifDexFetchDone(_ notification: NSNotification) {
        BaseData.instance.mSifDexMyAssets_gRPC.forEach { asset in
            if (!asset.symbol.starts(with: "ibc/")) {
                mMyEthAssets.append(asset.symbol)
            }
        }
        print("mMyEthAssets ", mMyEthAssets.count)
        
        BaseData.instance.mSifDexPools_gRPC.forEach { pool in
            if (!pool.externalAsset.symbol.starts(with: "ibc/")) {
                if (mMyEthAssets.contains(pool.externalAsset.symbol)) {
                    mMyEthPools.append(pool)
                } else {
                    mOtherEthPools.append(pool)
                }
            }
        }
        print("mMyEthPools ", mMyEthPools.count)
        print("mOtherEthPools ", mOtherEthPools.count)
        
        if (mMyEthAssets.count > 0) {
            self.mMyEthLps.removeAll()
            mFetchCnt = mMyEthAssets.count
            mMyEthAssets.forEach { symbol in
                onFetchMyLpInfo(account!.account_address, symbol)
            }
        }
    }
    
    var mFetchCnt = 0
    func onFetchFinished() {
        self.mFetchCnt = self.mFetchCnt - 1
        if (mFetchCnt > 0) { return }
        
        print("mMyEthLps ", mMyEthLps.count)
    }
    
    
    
    func onFetchMyLpInfo(_ address: String, _ denom: String) {
        DispatchQueue.global().async {
            do {
                let channel = BaseNetWork.getConnection(self.chainType!, MultiThreadedEventLoopGroup(numberOfThreads: 1))!
                let req = Sifnode_Clp_V1_LiquidityProviderReq.with { $0.lpAddress = address; $0.symbol = denom }
                if let response = try? Sifnode_Clp_V1_QueryClient(channel: channel).getLiquidityProvider(req, callOptions: BaseNetWork.getCallOptions()).response.wait() {
                    self.mMyEthLps.append(response)
                }
                try channel.close().wait()
                
            } catch {
                print("onFetchMyLpInfo failed: \(error)")
            }
            DispatchQueue.main.async(execute: { self.onFetchFinished() });
        }
    }

}
