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
    static func getSifCoinName(_ denom: String) -> String {
        if (denom == SIF_MAIN_DENOM) {
            return "ROWAN"
            
        } else if (denom.starts(with: "ibc/")) {
            if let ibcToken = BaseData.instance.getIbcToken(denom.replacingOccurrences(of: "ibc/", with: "")), let dpDenom = ibcToken.display_denom {
                return dpDenom.uppercased()
            } else {
                return"UnKnown"
            }
            
        } else if (denom.starts(with: "c")) {
            return denom.substring(from: 1).uppercased()
            
        }
        return denom
    }
    
    static func getSifCoinImg(_ denom: String) -> UIImage? {
        if (denom == SIF_MAIN_DENOM) {
            return UIImage(named: "tokensifchain")
            
        } else if (denom.starts(with: "ibc/")) {
            if let ibcToken = BaseData.instance.getIbcToken(denom.replacingOccurrences(of: "ibc/", with: "")), let url = URL(string: ibcToken.moniker ?? ""), let data = try? Data(contentsOf: url) {
                return UIImage(data: data)?.resized(to: CGSize(width: 20, height: 20))
            } else {
                return UIImage(named: "tokenDefaultIbc")
            }
            
        } else if (denom.starts(with: "c")) {
            if let url = URL(string: SIF_COIN_IMG_URL + denom + ".png"), let data = try? Data(contentsOf: url) {
                return UIImage(data: data)?.resized(to: CGSize(width: 20, height: 20))
            } else {
                return UIImage(named: "tokenIc")
            }
        }
        return UIImage(named: "tokenIc")
    }
    
    static func getSifCoinDecimal(_ denom:String?) -> Int16 {
        let sifTokens = BaseData.instance.mParam?.getSifTokens()
        if (sifTokens != nil) {
            return sifTokens?.filter({ $0.denom == denom }).first?.decimals ?? 18
        }
        return 18
    }
    
    static func DpSifCoinName(_ label: UILabel, _ denom: String) {
        if (denom == SIF_MAIN_DENOM) {
            label.textColor = COLOR_SIF
            label.text = "ROWAN"
            
        } else if (denom.starts(with: "ibc/")) {
            label.textColor = .white
            if let ibcToken = BaseData.instance.getIbcToken(denom.replacingOccurrences(of: "ibc/", with: "")), let dpDenom = ibcToken.display_denom {
                label.text = dpDenom.uppercased()
            } else {
                label.text = "UnKnown"
            }
            
        } else if (denom.starts(with: "c")) {
            label.textColor = .white
            label.text = denom.substring(from: 1).uppercased()
            
        } else {
            label.textColor = .white
            label.text = "UnKnown"
        }
    }
    
    static func DpSifCoinImg(_ imgView: UIImageView, _ denom: String) {
        if (denom == SIF_MAIN_DENOM) {
            imgView.image = UIImage(named: "tokensifchain")
            
        } else if (denom.starts(with: "ibc/")) {
            if let ibcToken = BaseData.instance.getIbcToken(denom.replacingOccurrences(of: "ibc/", with: "")), let url = URL(string: ibcToken.moniker ?? "") {
                imgView.af_setImage(withURL: url)
            } else {
                imgView.image = UIImage(named: "tokenDefaultIbc")
            }
            
        } else if (denom.starts(with: "c")) {
            if let url = URL(string: SIF_COIN_IMG_URL + denom + ".png") {
                imgView.af_setImage(withURL: url)
            } else {
                imgView.image = UIImage(named: "tokenIc")
            }
            
        } else {
            imgView.image = UIImage(named: "tokenIc")
        }
    }
    
    static func getPoolLpAmount(_ pool: Sifnode_Clp_V1_Pool, _ denom: String) -> NSDecimalNumber {
        if (denom == SIF_MAIN_DENOM) {
            return getNativeLpAmount(pool)
        } else {
            return getExternalLpAmount(pool)
        }
    }
    
    static func getNativeLpAmount(_ pool: Sifnode_Clp_V1_Pool) -> NSDecimalNumber {
        return NSDecimalNumber.init(string: pool.nativeAssetBalance)
    }
    
    static func getExternalLpAmount(_ pool: Sifnode_Clp_V1_Pool) -> NSDecimalNumber {
        return NSDecimalNumber.init(string: pool.externalAssetBalance)
    }
    
    static func getUnitAmount(_ pool: Sifnode_Clp_V1_Pool) -> NSDecimalNumber {
        return NSDecimalNumber.init(string: pool.poolUnits)
    }
    
    static func getBaseDenom(_ denom: String)  -> String {
        if (denom == SIF_MAIN_DENOM) {
            return SIF_MAIN_DENOM
            
        } else if (denom.starts(with: "ibc/")) {
            guard let ibcToken = BaseData.instance.getIbcToken(denom.replacingOccurrences(of: "ibc/", with: "")) else {
                return denom
            }
            if (ibcToken.auth == true) {
                return ibcToken.base_denom!
            }
            
        } else if (denom.starts(with: "c") || denom.starts(with: "x")) {
            return denom.substring(from: 1).uppercased()
            
        }
        return denom
    }
    
    static func getSifPoolValue(_ pool: Sifnode_Clp_V1_Pool) -> NSDecimalNumber {
        let rowanDecimal = getSifCoinDecimal(SIF_MAIN_DENOM)
        let rowanAmount = NSDecimalNumber.init(string: pool.nativeAssetBalance)
        let rowanPrice = perUsdValue(SIF_MAIN_DENOM) ?? NSDecimalNumber.zero
        
        let externalDecimal = getSifCoinDecimal(pool.externalAsset.symbol)
        let externalAmount = NSDecimalNumber.init(string: pool.externalAssetBalance)
        let exteranlBaseDenom = getBaseDenom(pool.externalAsset.symbol)
        let exteranlPrice = perUsdValue(exteranlBaseDenom) ?? NSDecimalNumber.zero
        
        let rowanValue = rowanAmount.multiplying(by: rowanPrice).multiplying(byPowerOf10: -rowanDecimal, withBehavior: WUtils.handler2)
        let exteranlValue = externalAmount.multiplying(by: exteranlPrice).multiplying(byPowerOf10: -externalDecimal, withBehavior: WUtils.handler2)
        return rowanValue.adding(exteranlValue)
    }
    
    static func getSifMyShareValue(_ pool: Sifnode_Clp_V1_Pool, _ myLp: Sifnode_Clp_V1_LiquidityProviderRes) -> NSDecimalNumber {
        let poolValue = getSifPoolValue(pool)
        let totalUnit = NSDecimalNumber.init(string: pool.poolUnits)
        let myUnit = NSDecimalNumber.init(string: myLp.liquidityProvider.liquidityProviderUnits)
        return poolValue.multiplying(by: myUnit).dividing(by: totalUnit, withBehavior: WUtils.handler2)
    }
}
