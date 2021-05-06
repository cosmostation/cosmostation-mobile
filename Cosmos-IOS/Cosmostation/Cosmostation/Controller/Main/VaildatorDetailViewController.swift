//
//  VaildatorDetailViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 04/04/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices
import GRPC
import NIO

class VaildatorDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chainBg: UIImageView!
    @IBOutlet weak var validatorDetailTableView: UITableView!
    @IBOutlet weak var loadingImg: LoadingImageView!
    
    var mValidator: Validator?
    var mBonding: BondingInfo?
    var mUnbonding: UnbondingInfo?
    var mRewardCoins = Array<Coin>()
    var mApiHistories = Array<ApiHistory.HistoryData>()
    var mSelfBondingShare: String?
    var mFetchCnt = 0
    var mMyValidator = false
    
    //grpc
    var mValidator_gRPC: Cosmos_Staking_V1beta1_Validator?
    var mSelfDelegationInfo_gRPC: Cosmos_Staking_V1beta1_DelegationResponse?
    var mApiCustomHistories = Array<ApiHistoryCustom>()
    
    var mInflation: String?
    var mProvision: String?
    var mStakingPool: NSDictionary?
    var mBandOracleStatus: BandOracleStatus?
    
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        
        self.validatorDetailTableView.delegate = self
        self.validatorDetailTableView.dataSource = self
        self.validatorDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.validatorDetailTableView.register(UINib(nibName: "ValidatorDetailMyDetailCell", bundle: nil), forCellReuseIdentifier: "ValidatorDetailMyDetailCell")
        self.validatorDetailTableView.register(UINib(nibName: "ValidatorDetailMyActionCell", bundle: nil), forCellReuseIdentifier: "ValidatorDetailMyActionCell")
        self.validatorDetailTableView.register(UINib(nibName: "ValidatorDetailCell", bundle: nil), forCellReuseIdentifier: "ValidatorDetailCell")
        self.validatorDetailTableView.register(UINib(nibName: "ValidatorDetailHistoryEmpty", bundle: nil), forCellReuseIdentifier: "ValidatorDetailHistoryEmpty")
        self.validatorDetailTableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        self.validatorDetailTableView.rowHeight = UITableView.automaticDimension
        self.validatorDetailTableView.estimatedRowHeight = UITableView.automaticDimension
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(onFech), for: .valueChanged)
        refresher.tintColor = UIColor.white
        validatorDetailTableView.addSubview(refresher)
        
        self.mInflation = BaseData.instance.mInflation
        self.mProvision = BaseData.instance.mProvision
        self.mStakingPool = BaseData.instance.mStakingPool
        self.mBandOracleStatus = BaseData.instance.mBandOracleStatus
        
        self.loadingImg.onStartAnimation()
        self.onFech()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_validator_detail", comment: "")
        self.navigationItem.title = NSLocalizedString("title_validator_detail", comment: "")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    @objc func onFech() {
        if (chainType == ChainType.KAVA_MAIN) {
            mRewardCoins.removeAll()
            mFetchCnt = 5
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            onFetchApiHistory(account!, mValidator!)
            
        } else if (chainType == ChainType.KAVA_TEST) {
            mRewardCoins.removeAll()
            mFetchCnt = 5
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            onFetchApiHistory(account!, mValidator!)
            
        } else if (chainType == ChainType.BAND_MAIN) {
            mRewardCoins.removeAll()
            mFetchCnt = 6
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            onFetchApiHistory(account!, mValidator!)
            onFetchBandOracleStatus()
            
        } else if (chainType == ChainType.SECRET_MAIN) {
            mRewardCoins.removeAll()
            mFetchCnt = 5
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            onFetchApiHistory(account!, mValidator!)
            
        } else if (chainType == ChainType.IOV_MAIN) {
            mRewardCoins.removeAll()
            mFetchCnt = 5
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            onFetchApiHistory(account!, mValidator!)
            
        } else if (chainType == ChainType.IOV_TEST ) {
            mRewardCoins.removeAll()
            mFetchCnt = 4
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            
        } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST || chainType == ChainType.SENTINEL_MAIN ||
                    chainType == ChainType.FETCH_MAIN || chainType == ChainType.SIF_MAIN || chainType == ChainType.KI_MAIN) {
            mRewardCoins.removeAll()
            mFetchCnt = 5
            onFetchValidatorInfo(mValidator!)
            onFetchSignleBondingInfo(account!, mValidator!)
            onFetchSignleUnBondingInfo(account!, mValidator!)
            onFetchSelfBondRate(WKey.getAddressFromOpAddress(mValidator!.operator_address, chainType!), mValidator!.operator_address)
            onFetchApiHistory(account!, mValidator!)
            
        }
        
        else if (WUtils.isGRPC(chainType!)) {
            self.mFetchCnt = 6
            BaseData.instance.mMyDelegations_gRPC.removeAll()
            BaseData.instance.mMyUnbondings_gRPC.removeAll()
            BaseData.instance.mMyReward_gRPC.removeAll()
            
            onFetchSingleValidator_gRPC(mValidator_gRPC!.operatorAddress)
            onFetchValidatorSelfBond_gRPC(WKey.getAddressFromOpAddress(mValidator_gRPC!.operatorAddress, chainType!), mValidator_gRPC!.operatorAddress)
            onFetchDelegations_gRPC(account!.account_address, 0)
            onFetchUndelegations_gRPC(account!.account_address, 0)
            onFetchRewards_gRPC(account!.account_address)
            onFetchApiHistoryCustom(account!.account_address, mValidator_gRPC!.operatorAddress)
        }
    }
    
    func onFetchFinished() {
        self.mFetchCnt = self.mFetchCnt - 1
//        print("onFetchFinished ", self.mFetchCnt)
        if (mFetchCnt <= 0) {
            if (WUtils.isGRPC(chainType!)) {
                self.validatorDetailTableView.reloadData()
                self.loadingImg.onStopAnimation()
                self.loadingImg.isHidden = true
                self.validatorDetailTableView.isHidden = false
                self.refresher.endRefreshing()
                
            } else {
                if (mBonding != nil || mUnbonding != nil) {
                    mMyValidator = true
                } else {
                    mMyValidator = false
                }
                self.mBandOracleStatus = BaseData.instance.mBandOracleStatus
                self.validatorDetailTableView.reloadData()
                self.loadingImg.onStopAnimation()
                self.loadingImg.isHidden = true
                self.validatorDetailTableView.isHidden = false
                self.refresher.endRefreshing()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (WUtils.isGRPC(chainType!)) {
            if (section == 0) {
                if (BaseData.instance.mMyValidators_gRPC.contains{ $0.operatorAddress == mValidator_gRPC?.operatorAddress }) { return 2 }
                else { return 1 }
            } else {
                if (mApiCustomHistories.count > 0) { return mApiCustomHistories.count }
                else { return 1 }
            }
        } else {
            if (section == 0) {
                if (mMyValidator) { return 2 }
                else { return 1 }
            } else {
                if (mApiHistories.count > 0) { return mApiHistories.count }
                else { return 1 }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ValidatorDetailHistoryHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (WUtils.isGRPC(chainType!)) {
            if (indexPath.section == 0) {
                if (indexPath.row == 0 && BaseData.instance.mMyValidators_gRPC.contains{ $0.operatorAddress == mValidator_gRPC?.operatorAddress }) {
                    return onSetMyValidatorItemsV1(tableView, indexPath)
                } else if (indexPath.row == 0 && !BaseData.instance.mMyValidators_gRPC.contains{ $0.operatorAddress == mValidator_gRPC?.operatorAddress }) {
                    return onSetValidatorItemsV1(tableView, indexPath)
                } else {
                    return onSetActionItemsV1(tableView, indexPath)
                }
            } else {
                return onSetHistoryItemsV1(tableView, indexPath)
            }
            
        } else {
            if (indexPath.section == 0) {
                if (indexPath.row == 0 && mMyValidator) {
                    return onSetMyValidatorItems(tableView, indexPath)
                } else if (indexPath.row == 0 && !mMyValidator) {
                    return onSetValidatorItems(tableView, indexPath)
                } else {
                    return onSetActionItems(tableView, indexPath)
                }
            } else {
                return onSetHistoryItems(tableView, indexPath)
            }
        }
    }
    
    
    func onSetMyValidatorItems(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell:ValidatorDetailMyDetailCell? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailMyDetailCell") as? ValidatorDetailMyDetailCell
        let dpDecimal = WUtils.mainDivideDecimal(chainType)
        cell?.monikerName.text = self.mValidator!.description.moniker
        cell?.monikerName.adjustsFontSizeToFitWidth = true
        if (self.mValidator!.jailed) {
            cell!.jailedImg.isHidden = false
            cell!.validatorImg.layer.borderColor = UIColor(hexString: "#f31963").cgColor
        } else {
            cell!.jailedImg.isHidden = true
            cell!.validatorImg.layer.borderColor = UIColor(hexString: "#4B4F54").cgColor
        }
        cell?.freeEventImg.isHidden = true
        cell?.website.text = mValidator!.description.website
        cell?.descriptionMsg.text = mValidator!.description.details
        cell?.actionTapUrl = {
            guard let url = URL(string: self.mValidator!.description.website) else { return }
            if (UIApplication.shared.canOpenURL(url)) {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.modalPresentationStyle = .popover
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
        cell!.commissionRate.attributedText = WUtils.displayCommission(mValidator!.commission.commission_rates.rate, font: cell!.commissionRate.font)
        cell?.totalBondedAmount.attributedText =  WUtils.displayAmount2(mValidator!.tokens, cell!.totalBondedAmount.font!, dpDecimal, dpDecimal)
        cell?.validatorImg.af_setImage(withURL: URL(string: WUtils.getMonikerImgUrl(chainType!, mValidator!.operator_address))!)
        
        if (mSelfBondingShare != nil) {
            cell!.selfBondedRate.attributedText = WUtils.displaySelfBondRate(mSelfBondingShare!, mValidator!.tokens, cell!.selfBondedRate.font)
        } else {
            cell!.selfBondedRate.attributedText = WUtils.displaySelfBondRate(NSDecimalNumber.zero.stringValue, mValidator!.tokens, cell!.selfBondedRate.font)
        }
        
        if (self.mValidator?.status == 2) {
            cell!.avergaeYield.attributedText = WUtils.getDpEstAprCommission(cell!.avergaeYield.font, mValidator!.getCommission(), chainType!)
        } else {
            cell!.avergaeYield.attributedText = WUtils.displayCommission(NSDecimalNumber.zero.stringValue, font: cell!.avergaeYield.font)
            cell!.avergaeYield.textColor = UIColor.init(hexString: "f31963")
        }
        
        if (chainType == ChainType.BAND_MAIN) {
            if let oracle = mBandOracleStatus?.isEnable(mValidator!.operator_address) {
                if (oracle) {
                    cell?.bandOracleImg.image = UIImage(named: "bandoracleonl")
                } else {
                    cell?.bandOracleImg.image = UIImage(named: "bandoracleoffl")
                    cell?.avergaeYield.textColor = UIColor.init(hexString: "f31963")
                }
                cell?.bandOracleImg.isHidden = false
            }
        }
        //temp hide apr for sifchain
        if (chainType == ChainType.SIF_MAIN) {
            cell!.avergaeYield.text = "--"
        }
        
        return cell!
    }
    
    func onSetValidatorItems(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell:ValidatorDetailCell? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailCell") as? ValidatorDetailCell
        let dpDecimal = WUtils.mainDivideDecimal(chainType)
        cell?.monikerName.text = self.mValidator!.description.moniker
        cell?.monikerName.adjustsFontSizeToFitWidth = true
        if(self.mValidator!.jailed) {
            cell?.jailedImg.isHidden = false
            cell?.validatorImg.layer.borderColor = UIColor(hexString: "#f31963").cgColor
        } else {
            cell?.jailedImg.isHidden = true
            cell?.validatorImg.layer.borderColor = UIColor(hexString: "#4B4F54").cgColor
        }
        cell?.freeEventImg.isHidden = true
        cell?.website.text = mValidator!.description.website
        cell?.descriptionMsg.text = mValidator!.description.details
        cell?.actionTapUrl = {
            guard let url = URL(string: self.mValidator!.description.website) else { return }
            if (UIApplication.shared.canOpenURL(url)) {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.modalPresentationStyle = .popover
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
        cell!.commissionRate.attributedText = WUtils.displayCommission(mValidator!.commission.commission_rates.rate, font: cell!.commissionRate.font)
        cell?.totalBondedAmount.attributedText =  WUtils.displayAmount2(mValidator!.tokens, cell!.totalBondedAmount.font!, dpDecimal, dpDecimal)
        cell?.validatorImg.af_setImage(withURL: URL(string: WUtils.getMonikerImgUrl(chainType!, mValidator!.operator_address))!)
        
        if (mSelfBondingShare != nil) {
            cell!.selfBondedRate.attributedText = WUtils.displaySelfBondRate(mSelfBondingShare!, mValidator!.tokens, cell!.selfBondedRate.font)
        } else {
            cell!.selfBondedRate.attributedText = WUtils.displaySelfBondRate(NSDecimalNumber.zero.stringValue, mValidator!.tokens, cell!.selfBondedRate.font)
        }
        
        if (self.mValidator?.status == 2) {
            cell!.avergaeYield.attributedText = WUtils.getDpEstAprCommission(cell!.avergaeYield.font, mValidator!.getCommission(), chainType!)
        } else {
            cell!.avergaeYield.attributedText = WUtils.displayCommission(NSDecimalNumber.zero.stringValue, font: cell!.avergaeYield.font)
            cell!.avergaeYield.textColor = UIColor.init(hexString: "f31963")
        }
        
        if (chainType == ChainType.BAND_MAIN) {
            if let oracle = mBandOracleStatus?.isEnable(mValidator!.operator_address) {
                if (oracle) {
                    cell?.bandOracleImg.image = UIImage(named: "bandoracleonl")
                } else {
                    cell?.bandOracleImg.image = UIImage(named: "bandoracleoffl")
                    cell?.avergaeYield.textColor = UIColor.init(hexString: "f31963")
                }
                cell?.bandOracleImg.isHidden = false
            }
        }
        //temp hide apr for sifchain
        if (chainType == ChainType.SIF_MAIN) {
            cell!.avergaeYield.text = "--"
        }
        
        cell?.actionDelegate = {
            if (self.mValidator!.jailed) {
                self.onShowToast(NSLocalizedString("error_jailded_delegate", comment: ""))
                return
            } else {
                self.onStartDelegate()
            }
        }
        return cell!
        
    }
    
    func onSetActionItems(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell:ValidatorDetailMyActionCell? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailMyActionCell") as? ValidatorDetailMyActionCell
        let dpDecimal = WUtils.mainDivideDecimal(chainType)
        
        cell?.cardView.backgroundColor = WUtils.getChainBg(chainType!)
        cell!.myDelegateAmount.attributedText =  WUtils.displayAmount2(mBonding?.getAmount().stringValue, cell!.myDelegateAmount.font, dpDecimal, dpDecimal)
        
        var unbondingAmount = NSDecimalNumber.zero
        mUnbonding?.entries.forEach { entry in
            unbondingAmount = unbondingAmount.adding(NSDecimalNumber.init(string: entry.balance))
        }
        cell!.myUndelegateAmount.attributedText =  WUtils.displayAmount2(unbondingAmount.stringValue, cell!.myUndelegateAmount.font, dpDecimal, dpDecimal)
        
        var rewardAmount = NSDecimalNumber.zero
        mRewardCoins.forEach { coin in
            if (coin.denom == WUtils.getMainDenom(chainType)) {
                rewardAmount = NSDecimalNumber.init(string:coin.amount)
            }
        }
        cell!.myRewardAmount.attributedText =  WUtils.displayAmount2(rewardAmount.stringValue, cell!.myRewardAmount.font, dpDecimal, dpDecimal)
        
        if (self.mValidator?.status == 2) {
            cell!.myDailyReturns.attributedText = WUtils.getDailyReward(cell!.myDailyReturns.font, mValidator!.getCommission(), mBonding?.getAmount(), chainType!)
            cell!.myMonthlyReturns.attributedText = WUtils.getMonthlyReward(cell!.myMonthlyReturns.font, mValidator!.getCommission(), mBonding?.getAmount(), chainType!)
            
        } else {
            cell!.myDailyReturns.attributedText =  WUtils.getDailyReward(cell!.myDailyReturns.font, NSDecimalNumber.one, NSDecimalNumber.zero, chainType!)
            cell!.myMonthlyReturns.attributedText =  WUtils.getDailyReward(cell!.myMonthlyReturns.font, NSDecimalNumber.one, NSDecimalNumber.zero, chainType!)
            cell!.myDailyReturns.textColor = UIColor.init(hexString: "f31963")
            cell!.myMonthlyReturns.textColor = UIColor.init(hexString: "f31963")
        }
        
        cell?.actionDelegate = {
            if (self.mValidator!.jailed) {
                self.onShowToast(NSLocalizedString("error_jailded_delegate", comment: ""))
                return
            } else {
                self.onStartDelegate()
            }
        }
        cell?.actionUndelegate = {
            self.onStartUndelegate()
        }
        cell?.actionRedelegate = {
            self.onCheckRedelegate()
        }
        cell?.actionReward = {
            self.onStartGetSingleReward()
        }
        cell?.actionReinvest = {
            self.onCheckReinvest()
        }
        
        //temp hide apr for sifchain
        if (chainType == ChainType.SIF_MAIN) {
            cell!.myDailyReturns.text = "--"
            cell!.myMonthlyReturns.text = "--"
        }
        return cell!
    }
    
    func onSetHistoryItems(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        if (mApiHistories.count > 0) {
            let cell:HistoryCell? = tableView.dequeueReusableCell(withIdentifier:"HistoryCell") as? HistoryCell
            let history = mApiHistories[indexPath.row]
            cell?.txBlockLabel.text = String(history.height) + " block"
            cell?.txTypeLabel.text = WUtils.historyTitle(history.msg, account!.account_address)
            cell?.txTimeLabel.text = WUtils.txTimetoString(input: history.time)
            cell?.txTimeGapLabel.text = WUtils.txTimeGap(input: history.time)
            if(history.isSuccess) {
                cell?.txResultLabel.isHidden = true
            } else {
                cell?.txResultLabel.isHidden = false
            }
            return cell!
        } else {
            let cell:ValidatorDetailHistoryEmpty? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailHistoryEmpty") as? ValidatorDetailHistoryEmpty
            return cell!
        }
    }
    
    //grpc
    func onSetMyValidatorItemsV1(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell:ValidatorDetailMyDetailCell? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailMyDetailCell") as? ValidatorDetailMyDetailCell
        cell?.updateView(self.mValidator_gRPC, self.mSelfDelegationInfo_gRPC, self.chainType)
        cell?.actionTapUrl = {
            guard let url = URL(string: self.mValidator_gRPC?.description_p.website ?? "") else { return }
            if (UIApplication.shared.canOpenURL(url)) {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.modalPresentationStyle = .popover
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
        return cell!
    }
    
    func onSetValidatorItemsV1(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell:ValidatorDetailCell? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailCell") as? ValidatorDetailCell
        cell?.updateView(self.mValidator_gRPC, self.mSelfDelegationInfo_gRPC, self.chainType)
        cell?.actionTapUrl = {
            guard let url = URL(string: self.mValidator_gRPC?.description_p.website ?? "") else { return }
            if (UIApplication.shared.canOpenURL(url)) {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.modalPresentationStyle = .popover
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
        cell?.actionDelegate = {
            if (self.mValidator_gRPC?.jailed == true) {
                self.onShowToast(NSLocalizedString("error_jailded_delegate", comment: ""))
                return
            } else {
                self.onStartDelegate()
            }
        }
        return cell!
    }
    
    func onSetActionItemsV1(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell:ValidatorDetailMyActionCell? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailMyActionCell") as? ValidatorDetailMyActionCell
        cell?.updateView(self.mValidator_gRPC, self.chainType)
        cell?.actionDelegate = {
            if (self.mValidator_gRPC?.jailed == true) {
                self.onShowToast(NSLocalizedString("error_jailded_delegate", comment: ""))
            } else {
                self.onStartDelegate()
            }
        }
        cell?.actionUndelegate = {
            self.onStartUndelegate()
        }
        cell?.actionRedelegate = {
            self.onCheckRedelegate()
        }
        cell?.actionReward = {
            self.onStartGetSingleReward()
        }
        cell?.actionReinvest = {
            self.onCheckReinvest()
        }
        return cell!
    }
    
    func onSetHistoryItemsV1(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        if (mApiCustomHistories.count > 0) {
            let cell:HistoryCell? = tableView.dequeueReusableCell(withIdentifier:"HistoryCell") as? HistoryCell
            let history = mApiCustomHistories[indexPath.row]
            cell?.txTimeLabel.text = WUtils.txTimetoString(input: history.timestamp)
            cell?.txTimeGapLabel.text = WUtils.txTimeGap(input: history.timestamp)
            cell?.txBlockLabel.text = String(history.height!) + " block"
            cell?.txTypeLabel.text = history.getMsgType(account!.account_address)
            if (history.isSuccess()) { cell?.txResultLabel.isHidden = true }
            else { cell?.txResultLabel.isHidden = false }
            return cell!
        } else {
            let cell:ValidatorDetailHistoryEmpty? = tableView.dequeueReusableCell(withIdentifier:"ValidatorDetailHistoryEmpty") as? ValidatorDetailHistoryEmpty
            return cell!
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1 && mApiHistories.count > 0) {
            let history = mApiHistories[indexPath.row]
            let txDetailVC = TxDetailViewController(nibName: "TxDetailViewController", bundle: nil)
            txDetailVC.mIsGen = false
            txDetailVC.mTxHash = history.tx_hash
            txDetailVC.hidesBottomBarWhenPushed = true
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(txDetailVC, animated: true)
            
        } else if (indexPath.section == 1 && mApiCustomHistories.count > 0) {
            let history = mApiCustomHistories[indexPath.row]
            let txDetailVC = TxDetailgRPCViewController(nibName: "TxDetailgRPCViewController", bundle: nil)
            txDetailVC.mIsGen = false
            txDetailVC.mTxHash = history.tx_hash
            txDetailVC.hidesBottomBarWhenPushed = true
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(txDetailVC, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        } else {
            return 30
        }
    }
    
    func onFetchValidatorInfo(_ validator: Validator) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_VALIDATORS + "/" + validator.operator_address
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_VALIDATORS + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_VALIDATORS + "/" + validator.operator_address
        }
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary,
                    let validator = responseData.object(forKey: "result") as? NSDictionary else {
                    self.onFetchFinished()
                    return
                }
                self.mValidator = Validator(validator as! [String : Any])
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchValidatorInfo ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    func onFetchSignleBondingInfo(_ account: Account, _ validator: Validator) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_BONDING + account.account_address + KAVA_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_BONDING + account.account_address + BAND_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_BONDING + account.account_address + SECRET_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_BONDING + account.account_address + IOV_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_BONDING + account.account_address + CERTIK_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_BONDING + account.account_address + SENTINEL_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_BONDING + account.account_address + FETCH_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_BONDING + account.account_address + SIF_BONDING_TAIL + "/" + validator.operator_address
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_BONDING + account.account_address + KAVA_TEST_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_BONDING + account.account_address + IOV_TEST_BONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_BONDING + account.account_address + CERTIK_TEST_BONDING_TAIL + "/" + validator.operator_address
        }
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary,
                    let rawData = responseData.object(forKey: "result") as? NSDictionary else {
                    self.onFetchFinished()
                    return
                }
                
                self.mBonding = BondingInfo.init(rawData)
                if (self.mBonding != nil) {
                    self.mFetchCnt = self.mFetchCnt + 1
                    self.onFetchRewardInfo(account, validator)
                }
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchSignleBondingInfo ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    func onFetchSignleUnBondingInfo(_ account: Account, _ validator: Validator) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_UNBONDING + account.account_address + KAVA_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_UNBONDING + account.account_address + BAND_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_UNBONDING + account.account_address + SECRET_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_UNBONDING + account.account_address + IOV_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_UNBONDING + account.account_address + CERTIK_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_UNBONDING + account.account_address + SENTINEL_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_UNBONDING + account.account_address + FETCH_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_UNBONDING + account.account_address + SIF_UNBONDING_TAIL + "/" + validator.operator_address
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_UNBONDING + account.account_address + KAVA_TEST_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_UNBONDING + account.account_address + IOV_TEST_UNBONDING_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_UNBONDING + account.account_address + CERTIK_TEST_UNBONDING_TAIL + "/" + validator.operator_address
        }
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary,
                    let rawData = responseData.object(forKey: "result") as? NSDictionary else {
                    self.onFetchFinished()
                    return
                }
                self.mUnbonding = UnbondingInfo.init(rawData)
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchSignleUnBondingInfo ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    func onFetchRewardInfo(_ account: Account, _ validator: Validator) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_REWARD_FROM_VAL + account.account_address + KAVA_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_REWARD_FROM_VAL + account.account_address + BAND_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_REWARD_FROM_VAL + account.account_address + SECRET_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_REWARD_FROM_VAL + account.account_address + IOV_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_REWARD_FROM_VAL + account.account_address + CERTIK_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_REWARD_FROM_VAL + account.account_address + SENTINEL_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_REWARD_FROM_VAL + account.account_address + FETCH_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_REWARD_FROM_VAL + account.account_address + SIF_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_REWARD_FROM_VAL + account.account_address + KAVA_TEST_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_REWARD_FROM_VAL + account.account_address + IOV_TEST_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_REWARD_FROM_VAL + account.account_address + CERTIK_TEST_REWARD_FROM_VAL_TAIL + "/" + validator.operator_address
        }
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary,
                    let rawRewards = responseData.object(forKey: "result") as? Array<NSDictionary> else {
                    self.onFetchFinished()
                    return;
                }
                for rawReward in rawRewards {
                    self.mRewardCoins.append(Coin.init(rawReward))
                }
                
                    
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchRewardInfo ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    func onFetchSelfBondRate(_ address: String, _ vAddress: String) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_BONDING + address + KAVA_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_BONDING + address + BAND_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_BONDING + address + SECRET_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_BONDING + address + IOV_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_BONDING + address + CERTIK_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_BONDING + address + SENTINEL_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_BONDING + address + FETCH_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_BONDING + address + SIF_BONDING_TAIL + "/" + vAddress
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_BONDING + address + KAVA_TEST_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_BONDING + address + IOV_TEST_BONDING_TAIL + "/" + vAddress
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_BONDING + address + CERTIK_TEST_BONDING_TAIL + "/" + vAddress
        }
        let request = Alamofire.request(url!, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let responseData = res as? NSDictionary,
                    let rawData = responseData.object(forKey: "result") as? NSDictionary else {
                    self.onFetchFinished()
                    return
                }
                self.mSelfBondingShare = BondingInfo.init(rawData).shares

            case .failure(let error):
                if (SHOW_LOG) { print("onFetchSelfBondRate ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    func onFetchRedelegatedState(_ address: String, _ to: String) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_REDELEGATION;
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_REDELEGATION;
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_REDELEGATION;
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_REDELEGATION;
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_REDELEGATION;
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_REDELEGATION;
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_REDELEGATION;
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_REDELEGATION;
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_REDELEGATION;
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_REDELEGATION;
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_REDELEGATION;
        }
        let request = Alamofire.request(url!, method: .get, parameters: ["delegator":address, "validator_to":to], encoding: URLEncoding.default, headers: [:]);
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                if let responseData = res as? NSDictionary,
                    let redelegateHistories = responseData.object(forKey: "result") as? Array<NSDictionary> {
                    if (redelegateHistories.count > 0) {
                        self.onShowToast(NSLocalizedString("error_redelegation_limitted", comment: ""))
                    } else {
                        self.onStartRedelegate()
                    }
                } else {
                    self.onStartRedelegate()
                }
                
            case .failure(let error):
                print("onFetchRedelegatedState ", error)
                self.onShowToast(NSLocalizedString("error_network", comment: ""))
            }
        }
    }
    
    func onFetchRewardAddress(_ accountAddr: String) {
        var url = ""
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_REWARD_ADDRESS + accountAddr + KAVA_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_REWARD_ADDRESS + accountAddr + BAND_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_REWARD_ADDRESS + accountAddr + SECRET_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_REWARD_ADDRESS + accountAddr + IOV_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_REWARD_ADDRESS + accountAddr + CERTIK_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_REWARD_ADDRESS + accountAddr + SENTINEL_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_REWARD_ADDRESS + accountAddr + FETCH_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_REWARD_ADDRESS + accountAddr + SIF_REWARD_ADDRESS_TAIL
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_REWARD_ADDRESS + accountAddr + KAVA_TEST_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_REWARD_ADDRESS + accountAddr + IOV_TEST_REWARD_ADDRESS_TAIL
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_REWARD_ADDRESS + accountAddr + CERTIK_TEST_REWARD_ADDRESS_TAIL
        }
        let request = Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]);
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
//              print("onFetchRewardAddress ", res)
                guard let responseData = res as? NSDictionary, let address = responseData.object(forKey: "result") as? String else {
                    self.onShowReInvsetFailDialog()
                    return;
                }
                let trimAddress = address.replacingOccurrences(of: "\"", with: "")
                if (trimAddress == accountAddr) {
                    self.onStartReInvest()
                } else {
                    self.onShowReInvsetFailDialog()
                }
                
            case .failure(let error):
                if(SHOW_LOG) { print("onFetchRewardAddress ", error) }
            }
        }
    }
    
    func onFetchBandOracleStatus() {
        let url = BAND_ORACLE_STATUS
        let request = Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]);
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let info = res as? [String : Any] else {
                    self.onFetchFinished()
                    return
                }
                BaseData.instance.mBandOracleStatus = BandOracleStatus.init(info)
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchBandOracleStatus ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    func onFetchApiHistory(_ account: Account, _ validator: Validator) {
        var url: String?
        if (chainType == ChainType.KAVA_MAIN) {
            url = KAVA_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.BAND_MAIN) {
            url = BAND_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.IOV_MAIN) {
            url = IOV_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.SECRET_MAIN) {
            url = SECRET_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_MAIN) {
            url = CERTIK_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            url = SENTINEL_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.FETCH_MAIN) {
            url = FETCH_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.SIF_MAIN) {
            url = SIF_API_HISTORY + account.account_address + "/" + validator.operator_address
        }
        else if (chainType == ChainType.KAVA_TEST) {
            url = KAVA_TEST_API_HISTORY + account.account_address + "/" + validator.operator_address
        } else if (chainType == ChainType.CERTIK_TEST) {
            url = CERTIK_TEST_API_HISTORY + account.account_address + "/" + validator.operator_address
        }
        let request = Alamofire.request(url!, method: .get, parameters: ["limit":"50"], encoding: URLEncoding.default, headers: [:]);
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                self.mApiHistories.removeAll()
                guard let histories = res as? Array<NSDictionary> else {
//                    print("no history!!")
                    self.onFetchFinished()
                    return;
                }
                for rawHistory in histories {
                    self.mApiHistories.append(ApiHistory.HistoryData.init(rawHistory))
                }
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchApiHistory ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    
    //gRPC
    func onFetchSingleValidator_gRPC(_ opAddress: String) {
//        print("onFetchSingleValidator_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Staking_V1beta1_QueryValidatorRequest.with {
                $0.validatorAddr = opAddress
            }
            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel).validator(req).response.wait()
//                print("onFetchSingleValidator_gRPC: \(response.validator)")
                self.mValidator_gRPC = response.validator
            } catch {
                print("onFetchgRPCBondedValidators failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.onFetchFinished()
            });
        }
    }
    
    func onFetchValidatorSelfBond_gRPC(_ address: String, _ opAddress: String) {
//        print("onFetchValidatorSelfBond_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Staking_V1beta1_QueryDelegationRequest.with {
                $0.delegatorAddr = address
                $0.validatorAddr = opAddress
            }
            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel).delegation(req).response.wait()
//                print("onFetchValidatorSelfBond_gRPC: \(response.delegationResponse)")
                self.mSelfDelegationInfo_gRPC = response.delegationResponse
            } catch {
                print("onFetchValidatorSelfBond_gRPC failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.onFetchFinished()
            });
        }
        
    }
    
    func onFetchDelegations_gRPC(_ address: String, _ offset: Int) {
//        print("onFetchDelegations_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Staking_V1beta1_QueryDelegatorDelegationsRequest.with {
                $0.delegatorAddr = address
            }
            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel).delegatorDelegations(req).response.wait()
                response.delegationResponses.forEach { delegationResponse in
                    BaseData.instance.mMyDelegations_gRPC.append(delegationResponse)
                }
            } catch {
                print("onFetchDelegations_gRPC failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.onFetchFinished()
            });
        }
    }
    
    func onFetchUndelegations_gRPC(_ address: String, _ offset: Int) {
//        print("onFetchUndelegations_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Staking_V1beta1_QueryDelegatorUnbondingDelegationsRequest.with {
                $0.delegatorAddr = address
            }
            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel).delegatorUnbondingDelegations(req).response.wait()
                response.unbondingResponses.forEach { unbondingResponse in
                    BaseData.instance.mMyUnbondings_gRPC.append(unbondingResponse)
                }
            } catch {
                print("onFetchUndelegations_gRPC failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.onFetchFinished()
            });
        }
    }
    
    func onFetchRewards_gRPC(_ address: String) {
//        print("onFetchRewards_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Distribution_V1beta1_QueryDelegationTotalRewardsRequest.with {
                $0.delegatorAddress = address
            }
            do {
                let response = try Cosmos_Distribution_V1beta1_QueryClient(channel: channel).delegationTotalRewards(req).response.wait()
                response.rewards.forEach { reward in
                    BaseData.instance.mMyReward_gRPC.append(reward)
                }
            } catch {
                print("onFetchgRPCRewards failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.onFetchFinished()
            });
        }
    }
    
    func onFetchRedelegation_gRPC(_ address: String, _ toValAddress: String) {
//        print("onFetchRedelegation_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Staking_V1beta1_QueryRedelegationsRequest.with {
                $0.delegatorAddr = address
            }
            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel).redelegations(req).response.wait()
                let redelegation_responses = response.redelegationResponses
                for redelegation in redelegation_responses {
                    if (redelegation.redelegation.validatorDstAddress == self.mValidator_gRPC?.operatorAddress) {
                        DispatchQueue.main.async(execute: { self.onShowToast(NSLocalizedString("error_redelegation_limitted", comment: "")) });
                        return
                    }
                }
                DispatchQueue.main.async(execute: { self.onStartRedelegate() });
                
            } catch {
                print("onFetchRedelegation_gRPC failed: \(error)")
            }
            DispatchQueue.main.async(execute: {
                self.onFetchFinished()
            });
        }
    }
    
    func onFetchRewardsAddress_gRPC(_ address: String) {
//        print("onFetchRewardsAddress_gRPC")
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = BaseNetWork.getConnection(self.chainType!, group)!
            defer { try! channel.close().wait() }
            
            let req = Cosmos_Distribution_V1beta1_QueryDelegatorWithdrawAddressRequest.with {
                $0.delegatorAddress = address
            }
            do {
                let response = try Cosmos_Distribution_V1beta1_QueryClient(channel: channel).delegatorWithdrawAddress(req).response.wait()
                if (response.withdrawAddress.replacingOccurrences(of: "\"", with: "") != address) {
                    DispatchQueue.main.async(execute: { self.onShowReInvsetFailDialog() });
                    return;
                } else {
                    DispatchQueue.main.async(execute: { self.onStartReInvest() });
                }
            } catch {
                print("onFetchRedelegation_gRPC failed: \(error)")
            }
            
        }
    }
    
    func onFetchApiHistoryCustom(_ address: String, _ valAddress: String) {
        let url = BaseNetWork.accountStakingHistory(chainType!, address, valAddress)
        let request = Alamofire.request(url, method: .get, parameters: ["limit":"50"], encoding: URLEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                self.mApiCustomHistories.removeAll()
                guard let responseDatas = res as? Array<NSDictionary> else {
                    if (SHOW_LOG) { print("no history!!") }
                    self.onFetchFinished()
                    return;
                }
                for responseData in responseDatas {
                    self.mApiCustomHistories.append(ApiHistoryCustom(responseData))
                }
                if (SHOW_LOG) { print("mApiCustomHistories cnt ", self.mApiCustomHistories.count) }
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchApiHistoryCustom ", error) }
            }
            self.onFetchFinished()
        }
    }
    
    
    // user Actions
    func onStartDelegate() {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        
        let balances = BaseData.instance.selectBalanceById(accountId: account!.account_id)
        if (chainType == ChainType.KAVA_MAIN || chainType == ChainType.KAVA_TEST) {
            if (WUtils.getDelegableAmount(balances, KAVA_MAIN_DENOM).compare(NSDecimalNumber.zero).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_delegable", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.BAND_MAIN) {
            if (WUtils.getTokenAmount(balances, BAND_MAIN_DENOM).compare(NSDecimalNumber.zero).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SECRET_MAIN) {
            if (WUtils.getTokenAmount(balances, SECRET_MAIN_DENOM).compare(NSDecimalNumber.init(string: "50000")).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.IOV_MAIN) {
            if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(NSDecimalNumber.init(string: "200000")).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.IOV_TEST) {
            if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(NSDecimalNumber.init(string: "200000")).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST) {
            if (WUtils.getTokenAmount(balances, CERTIK_MAIN_DENOM).compare(NSDecimalNumber.init(string: "10000")).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_DELEGATE, 0)
            if (WUtils.getTokenAmount(balances, SENTINEL_MAIN_DENOM).compare(feeAmount).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.FETCH_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_DELEGATE, 0)
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SIF_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_DELEGATE, 0)
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.KI_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_DELEGATE, 0)
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
        }
        
        else if (WUtils.isGRPC(chainType!)) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_DELEGATE, 0)
            if (BaseData.instance.getDelegatable(WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue <= 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else {
            self.onShowToast(NSLocalizedString("error_support_soon", comment: ""))
            return
        }
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        if (WUtils.isGRPC(chainType!)) {
            txVC.mType = COSMOS_MSG_TYPE_DELEGATE
            txVC.mTargetValidator_gRPC = mValidator_gRPC
        } else {
            txVC.mType = COSMOS_MSG_TYPE_DELEGATE
            txVC.mTargetValidator = mValidator
        }
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
        
    }
    
    func onStartUndelegate() {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        let balances = BaseData.instance.selectBalanceById(accountId: account!.account_id)
        if (chainType == ChainType.KAVA_MAIN || chainType == ChainType.KAVA_TEST) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.IOV_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(NSDecimalNumber.init(string: "200000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.BAND_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, CERTIK_MAIN_DENOM).compare(NSDecimalNumber.init(string: "10000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SECRET_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, SECRET_MAIN_DENOM).compare(NSDecimalNumber.init(string: "50000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.IOV_TEST) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(NSDecimalNumber.init(string: "200000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_UNDELEGATE2, 0)
            if (WUtils.getTokenAmount(balances, SENTINEL_MAIN_DENOM).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.FETCH_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_UNDELEGATE2, 0)
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SIF_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_UNDELEGATE2, 0)
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.KI_MAIN) {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let entries = mUnbonding?.entries.count, entries > 7 {
                self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                return
            }
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_UNDELEGATE2, 0)
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        }
        
        else if (WUtils.isGRPC(chainType!)) {
            if (BaseData.instance.mMyDelegations_gRPC.filter { $0.delegation.validatorAddress == mValidator_gRPC?.operatorAddress}.first == nil) {
                self.onShowToast(NSLocalizedString("error_not_undelegate", comment: ""))
                return
            }
            if let unbonding = BaseData.instance.mMyUnbondings_gRPC.filter({ $0.validatorAddress == mValidator_gRPC?.operatorAddress}).first {
                if (unbonding.entries.count >= 7) {
                    self.onShowToast(NSLocalizedString("error_unbonding_count_over", comment: ""))
                    return
                }
            }
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_UNDELEGATE2, 0)
            if (BaseData.instance.getAvailableAmount(WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else {
            self.onShowToast(NSLocalizedString("error_support_soon", comment: ""))
            return
        }
        
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        if (WUtils.isGRPC(chainType!)) {
            txVC.mTargetValidator_gRPC = mValidator_gRPC
            txVC.mType = COSMOS_MSG_TYPE_UNDELEGATE2
        } else {
            txVC.mTargetValidator = mValidator
            txVC.mType = COSMOS_MSG_TYPE_UNDELEGATE2
        }
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
        
    }
    
    func onCheckRedelegate() {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        if (WUtils.isGRPC(chainType!)) {
            if (BaseData.instance.mMyDelegations_gRPC.filter { $0.delegation.validatorAddress == mValidator_gRPC?.operatorAddress}.first == nil) {
                self.onShowToast(NSLocalizedString("error_not_redelegate", comment: ""))
                return
            }
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_REDELEGATE2, 0)
            if (BaseData.instance.getAvailableAmount(WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            self.onFetchRedelegation_gRPC(account!.account_address, mValidator_gRPC!.operatorAddress)
            
        } else {
            if (mBonding == nil || mBonding!.getAmount() == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_redelegate", comment: ""))
                return
            }

            let balances = BaseData.instance.selectBalanceById(accountId: account!.account_id)
            if (chainType == ChainType.KAVA_MAIN || chainType == ChainType.KAVA_TEST || chainType == ChainType.BAND_MAIN) {
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.SECRET_MAIN) {
                if (WUtils.getTokenAmount(balances, SECRET_MAIN_DENOM).compare(NSDecimalNumber.init(string: "75000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.IOV_MAIN) {
                if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(NSDecimalNumber.init(string: "300000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.IOV_TEST) {
                if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(NSDecimalNumber.init(string: "300000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST) {
                if (WUtils.getTokenAmount(balances, CERTIK_MAIN_DENOM).compare(NSDecimalNumber.init(string: "15000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.SENTINEL_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_REDELEGATE2, 0)
                if (WUtils.getTokenAmount(balances, SENTINEL_MAIN_DENOM).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.FETCH_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_REDELEGATE2, 0)
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.SIF_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_REDELEGATE2, 0)
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else if (chainType == ChainType.KI_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_REDELEGATE2, 0)
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                self.onFetchRedelegatedState(account!.account_address, mValidator!.operator_address)
                
            } else {
                self.onShowToast(NSLocalizedString("error_support_soon", comment: ""))
                return
            }
        }
        
    }
    
    func onStartRedelegate() {
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        if (WUtils.isGRPC(chainType!)) {
            txVC.mTargetValidator_gRPC = mValidator_gRPC
            txVC.mType = COSMOS_MSG_TYPE_REDELEGATE2
        } else {
            txVC.mTargetValidator = mValidator
            txVC.mType = COSMOS_MSG_TYPE_REDELEGATE2
        }
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
    }
    
    func onStartGetSingleReward() {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        
        let balances = BaseData.instance.selectBalanceById(accountId: account!.account_id)
        if (chainType == ChainType.KAVA_MAIN || chainType == ChainType.KAVA_TEST) {
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(NSDecimalNumber.one).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.BAND_MAIN) {
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(NSDecimalNumber.one).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SECRET_MAIN) {
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(NSDecimalNumber.init(string: "50000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, SECRET_MAIN_DENOM).compare(NSDecimalNumber.init(string: "50000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.IOV_MAIN) {
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(NSDecimalNumber.init(string: "200000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(NSDecimalNumber.init(string: "200000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.IOV_TEST) {
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(NSDecimalNumber.init(string: "200000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(NSDecimalNumber.init(string: "200000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST) {
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(NSDecimalNumber.init(string: "10000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, CERTIK_MAIN_DENOM).compare(NSDecimalNumber.init(string: "10000")).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SENTINEL_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_DEL, 1)
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, SENTINEL_MAIN_DENOM).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.FETCH_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_DEL, 1)
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.SIF_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_DEL, 1)
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
            
        } else if (chainType == ChainType.KI_MAIN) {
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_DEL, 1)
            let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
            if (rewardSum == NSDecimalNumber.zero) {
                self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                return
            }
            if (rewardSum.compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                return
            }
        }
        
        else if (WUtils.isGRPC(chainType!)) {
            let reward = BaseData.instance.getReward(WUtils.getMainDenom(chainType), mValidator_gRPC?.operatorAddress)
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MSG_TYPE_WITHDRAW_DEL, 1)
            if (reward.compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (BaseData.instance.getAvailableAmount(WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            
        } else {
            self.onShowToast(NSLocalizedString("error_support_soon", comment: ""))
            return
        }
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        if (WUtils.isGRPC(chainType!)) {
            var validators = Array<Cosmos_Staking_V1beta1_Validator>()
            validators.append(mValidator_gRPC!)
            txVC.mRewardTargetValidators_gRPC = validators
            txVC.mType = COSMOS_MSG_TYPE_WITHDRAW_DEL
        } else {
            var validators = Array<Validator>()
            validators.append(mValidator!)
            txVC.mRewardTargetValidators = validators
            txVC.mType = COSMOS_MSG_TYPE_WITHDRAW_DEL
        }
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
        
    }
    
    func onCheckReinvest() {
        if(!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        if (WUtils.isGRPC(chainType!)) {
            let reward = BaseData.instance.getReward(WUtils.getMainDenom(chainType), mValidator_gRPC?.operatorAddress)
            let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MULTI_MSG_TYPE_REINVEST, 0)
            if (reward.compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                return
            }
            if (BaseData.instance.getAvailableAmount(WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_available", comment: ""))
                return
            }
            self.onFetchRewardsAddress_gRPC(account!.account_address)
            
        } else {
            let balances = BaseData.instance.selectBalanceById(accountId: account!.account_id)
            if (chainType == ChainType.KAVA_MAIN || chainType == ChainType.KAVA_TEST) {
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(NSDecimalNumber.one).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.BAND_MAIN) {
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(NSDecimalNumber.one).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.SECRET_MAIN) {
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(NSDecimalNumber.init(string: "87500")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, SECRET_MAIN_DENOM).compare(NSDecimalNumber.init(string: "87500")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.IOV_MAIN) {
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(NSDecimalNumber.init(string: "300000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(NSDecimalNumber.init(string: "300000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.IOV_TEST) {
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(NSDecimalNumber.init(string: "300000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(NSDecimalNumber.init(string: "300000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.CERTIK_MAIN || chainType == ChainType.CERTIK_TEST) {
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(NSDecimalNumber.init(string: "15000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, CERTIK_MAIN_DENOM).compare(NSDecimalNumber.init(string: "15000")).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.SENTINEL_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MULTI_MSG_TYPE_REINVEST, 0)
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.FETCH_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MULTI_MSG_TYPE_REINVEST, 0)
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.SIF_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MULTI_MSG_TYPE_REINVEST, 0)
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            } else if (chainType == ChainType.KI_MAIN) {
                let feeAmount = WUtils.getEstimateGasFeeAmount(chainType!, COSMOS_MULTI_MSG_TYPE_REINVEST, 0)
                let rewardSum = WUtils.plainStringToDecimal(mRewardCoins.filter { $0.denom == WUtils.getMainDenom(chainType)}.first?.amount)
                if (rewardSum == NSDecimalNumber.zero) {
                    self.onShowToast(NSLocalizedString("error_not_reward", comment: ""))
                    return
                }
                if (rewardSum.compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_wasting_fee", comment: ""))
                    return
                }
                if (WUtils.getTokenAmount(balances, WUtils.getMainDenom(chainType)).compare(feeAmount).rawValue < 0) {
                    self.onShowToast(NSLocalizedString("error_not_enough_fee", comment: ""))
                    return
                }
                
            }
            
            else {
                self.onShowToast(NSLocalizedString("error_support_soon", comment: ""))
                return
            }
            self.onFetchRewardAddress(account!.account_address)
        }
    }
    
    func onStartReInvest() {
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        if (WUtils.isGRPC(chainType!)) {
            txVC.mTargetValidator_gRPC = self.mValidator_gRPC
        } else {
            txVC.mTargetValidator = self.mValidator
        }
        txVC.mType = COSMOS_MULTI_MSG_TYPE_REINVEST
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
    }
    
    func onShowReInvsetFailDialog() {
        let alert = UIAlertController(title: NSLocalizedString("error_reward_address_changed_title", comment: ""), message: NSLocalizedString("error_reward_address_changed_msg", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

