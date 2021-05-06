//
//  DomainDetailViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2020/10/28.
//  Copyright © 2020 wannabit. All rights reserved.
//

import UIKit
import Alamofire

class DomainDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myDomainLabel: UILabel!
    @IBOutlet weak var myDomainType: UILabel!
    @IBOutlet weak var myDomainAddressCntLael: UILabel!
    @IBOutlet weak var myDomainExpireTimeLabel: UILabel!
    @IBOutlet weak var myDomainResourceTableView: UITableView!
    @IBOutlet weak var myDomainEmptyView: UIView!
    
    var mMyDomain: String?
    var mMyDomainInfo: IovStarNameDomainInfo?
    var mMyDomainResolve: IovStarNameResolve?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        self.balances = account!.account_balances
        
        self.myDomainResourceTableView.delegate = self
        self.myDomainResourceTableView.dataSource = self
        self.myDomainResourceTableView.register(UINib(nibName: "ResourceCell", bundle: nil), forCellReuseIdentifier: "ResourceCell")
        self.myDomainResourceTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.myDomainResourceTableView.rowHeight = UITableView.automaticDimension
        self.myDomainResourceTableView.estimatedRowHeight = UITableView.automaticDimension
        self.myDomainEmptyView.isHidden = true
        
        myDomainLabel.text = "*" + mMyDomain!
        self.onFetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_starname_domain_detail", comment: "")
        self.navigationItem.title = NSLocalizedString("title_starname_domain_detail", comment: "")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (mMyDomainResolve != nil && mMyDomainResolve?.result.account.resources != nil) {
            return mMyDomainResolve!.result.account.resources.count
        } else {
            return 0
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ResourceCell? = tableView.dequeueReusableCell(withIdentifier:"ResourceCell") as? ResourceCell
        let resource = mMyDomainResolve?.result.account.resources[indexPath.row]
        cell?.chainImg.image = WUtils.getStarNameChainImg(resource!)
        cell?.chainName.text = WUtils.getStarNameChainName(resource!)
        cell?.chainAddress.text = resource?.resource
        return cell!
    }

    @IBAction func onClickDelete(_ sender: UIButton) {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        if (mMyDomainInfo?.result.domain?.type == "open") {
            self.onShowToast(NSLocalizedString("error_cannot_delete_open_domain", comment: ""))
            return
        }
        
        let needFee = NSDecimalNumber.init(string: "150000")
        if (chainType == ChainType.IOV_MAIN) {
            if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(needFee).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_starname_fee", comment: ""))
                return
            }
        } else if (chainType == ChainType.IOV_TEST) {
            if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(needFee).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_starname_fee", comment: ""))
                return
            }
        } else {
            self.onShowToast(NSLocalizedString("error_disable", comment: ""))
            return
        }
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        txVC.mType = IOV_MSG_TYPE_DELETE_DOMAIN
        txVC.mStarnameDomain = mMyDomain
        txVC.mStarnameTime = mMyDomainInfo!.result.domain!.valid_until
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
    }
    
    @IBAction func onClickRenew(_ sender: UIButton) {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        
        let needFee = BaseData.instance.mStarNameFee!.getDomainRenewFee(mMyDomainInfo!.result.domain!.type).adding(NSDecimalNumber.init(string: "300000"))
        if (chainType == ChainType.IOV_MAIN) {
            if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(needFee).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_starname_fee", comment: ""))
                return
            }
        } else if (chainType == ChainType.IOV_TEST) {
            if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(needFee).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_starname_fee", comment: ""))
                return
            }
        } else {
            self.onShowToast(NSLocalizedString("error_disable", comment: ""))
            return
        }
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        txVC.mType = IOV_MSG_TYPE_RENEW_DOMAIN
        txVC.mStarnameDomain = mMyDomain
        txVC.mStarnameTime = mMyDomainInfo!.result.domain!.valid_until
        txVC.mStarnameDomainType = mMyDomainInfo?.result.domain?.type
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
    }
    
    @IBAction func onClickReplace(_ sender: UIButton) {
        if (!account!.account_has_private) {
            self.onShowAddMenomicDialog()
            return
        }
        
        let needFee = BaseData.instance.mStarNameFee!.getReplaceFee().adding(NSDecimalNumber.init(string: "300000"))
        if (chainType == ChainType.IOV_MAIN) {
            if (WUtils.getTokenAmount(balances, IOV_MAIN_DENOM).compare(needFee).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_starname_fee", comment: ""))
                return
            }
        } else if (chainType == ChainType.IOV_TEST) {
            if (WUtils.getTokenAmount(balances, IOV_TEST_DENOM).compare(needFee).rawValue < 0) {
                self.onShowToast(NSLocalizedString("error_not_enough_starname_fee", comment: ""))
                return
            }
        } else {
            self.onShowToast(NSLocalizedString("error_disable", comment: ""))
            return
        }
        
        let txVC = UIStoryboard(name: "GenTx", bundle: nil).instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        txVC.mType = IOV_MSG_TYPE_REPLACE_ACCOUNT_RESOURCE
        txVC.mStarnameDomain = mMyDomain
        txVC.mStarnameTime = mMyDomainInfo!.result.domain!.valid_until
        txVC.mStarnameDomainType = mMyDomainInfo?.result.domain?.type
        txVC.mStarnameResources = mMyDomainResolve?.result.account.resources ?? Array<StarNameResource>()
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(txVC, animated: true)
    }
    
    @IBAction func onClickProfile(_ sender: UIButton) {
        guard let url = URL(string: "https://starname.me/" + "*" + mMyDomain!) else { return }
        self.onShowSafariWeb(url)
    }
    
    var mFetchCnt = 0
    @objc func onFetchData() {
        if (self.mFetchCnt > 0)  {
            return
        }
        self.mFetchCnt = 2
        self.onFetchDomainInfo(mMyDomain!)
        self.onFetchResolve(mMyDomain!)
    }
    
    func onFetchFinished() {
        self.mFetchCnt = self.mFetchCnt - 1
        if (mFetchCnt <= 0) {
            if (mMyDomainResolve != nil && mMyDomainResolve?.result.account.resources != nil &&  mMyDomainResolve!.result.account.resources.count > 0) {
                self.myDomainResourceTableView.reloadData()
                self.myDomainEmptyView.isHidden = true
                self.myDomainAddressCntLael.text = String(mMyDomainResolve!.result.account.resources.count)
            } else {
                self.myDomainResourceTableView.isHidden = true
                self.myDomainEmptyView.isHidden = false
                self.myDomainAddressCntLael.text = "0"
            }
            myDomainExpireTimeLabel.text = WUtils.longTimetoString(input: mMyDomainInfo!.result.domain!.valid_until * 1000)
            myDomainType.text = mMyDomainInfo?.result.domain!.type.uppercased()
            if (mMyDomainInfo?.result.domain?.type == "open") {
                myDomainType.textColor = COLOR_IOV
            } else {
                myDomainType.textColor = .white
            }
        }
    }
    
    func onFetchDomainInfo(_ domain: String) {
        var url: String?
        if (chainType == ChainType.IOV_MAIN) {
            url = IOV_STARNAME_DOMAIN_INFO;
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_STARNAME_DOMAIN_INFO;
        }
        let request = Alamofire.request(url!, method: .post, parameters: ["name" : domain], encoding: JSONEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let info = res as? [String : Any] else {
                    self.onFetchFinished()
                    return
                }
                self.mMyDomainInfo = IovStarNameDomainInfo.init(info)
                self.onFetchFinished()
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchDomainInfo ", error) }
                self.onFetchFinished()
            }
        }
    }
    
    
    func onFetchResolve(_ starname: String) {
        var url: String?
        if (chainType == ChainType.IOV_MAIN) {
            url = IOV_CHECK_WITH_STARNAME;
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_CHECK_WITH_STARNAME;
        }
        let request = Alamofire.request(url!, method: .post, parameters: ["starname" : "*" + starname], encoding: JSONEncoding.default, headers: [:])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let info = res as? [String : Any], info["error"] == nil else {
                    self.onFetchFinished()
                    return
                }
                self.mMyDomainResolve = IovStarNameResolve.init(info)
                self.onFetchFinished()
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchResolve ", error) }
                self.onFetchFinished()
            }
        }
    }
}
