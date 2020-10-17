//
//  MyDomainViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2020/10/10.
//  Copyright © 2020 wannabit. All rights reserved.
//

import UIKit
import Alamofire

class MyDomainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myDomainTableView: UITableView!
    @IBOutlet weak var myDomainCnt: UILabel!
    
    var refresher: UIRefreshControl!
    var myDomains: Array<StarNameDomain> = Array<StarNameDomain>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.chainType = WUtils.getChainType(account!.account_base_chain)
        
        self.myDomainTableView.delegate = self
        self.myDomainTableView.dataSource = self
        self.myDomainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.myDomainTableView.register(UINib(nibName: "DomainPromotionCell", bundle: nil), forCellReuseIdentifier: "DomainPromotionCell")
        self.myDomainTableView.register(UINib(nibName: "DomainCell", bundle: nil), forCellReuseIdentifier: "DomainCell")
        self.myDomainTableView.rowHeight = UITableView.automaticDimension
        self.myDomainTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.refresher = UIRefreshControl()
        self.refresher.addTarget(self, action: #selector(onRequestFetch), for: .valueChanged)
        self.refresher.tintColor = UIColor.white
        self.myDomainTableView.addSubview(refresher)
        
        self.showWaittingAlert()
        self.onFetchMyDomain(self.account!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.myDomains.count <= 0) {
            return 1
        } else {
            return self.myDomains.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.myDomains.count <= 0) {
            let cell:DomainPromotionCell? = tableView.dequeueReusableCell(withIdentifier:"DomainPromotionCell") as? DomainPromotionCell
            return cell!
            
        } else {
            let cell:DomainCell? = tableView.dequeueReusableCell(withIdentifier:"DomainCell") as? DomainCell
            let starnameAccount = myDomains[indexPath.row]
            cell?.starNameLabel.text = "*" + starnameAccount.name
            cell?.domainTypeLabel.text = starnameAccount.type.uppercased()
            cell?.domainExpireTime.text = WUtils.longTimetoString(input: starnameAccount.valid_until * 1000)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (self.myDomains.count > 0) {
//            let starnameAccount = myDomains[indexPath.row]
//            print("start detail ", indexPath.row)
//        }
    }
    
    func onFetchFinished() {
        self.myDomainCnt.text = String(myDomains.count)
        self.myDomainTableView.reloadData()
        self.refresher.endRefreshing()
        self.hideWaittingAlert()
    }
    
    @IBAction func onClickBuy(_ sender: UIButton) {
        self.onShowToast(NSLocalizedString("error_not_yet", comment: ""))
    }
    
    
    @objc func onRequestFetch() {
        self.myDomains.removeAll()
        self.onFetchMyDomain(self.account!)
    }
    
    var domainOffset = 1
    func onFetchMyDomain(_ account:Account) {
        var url: String?
        if (chainType == ChainType.IOV_MAIN) {
            url = IOV_CHECK_MY_DOMAIN;
        } else if (chainType == ChainType.IOV_TEST) {
            url = IOV_TEST_CHECK_MY_DOMAIN;
        }
        let param = ["owner":account.account_address, "results_per_page": 100, "offset":1] as [String : Any]
        let request = Alamofire.request(url!, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]);
        request.responseJSON { (response) in
            switch response.result {
            case .success(let res):
                guard let info = res as? [String : Any] else {
                    self.onFetchFinished()
                    return
                }
                let iovStarNameDomain = IovStarNameDomain.init(info)
                self.myDomains.append(contentsOf: iovStarNameDomain.result.Domains)
                
                if (iovStarNameDomain.result.Domains.count == 100) {
                    self.domainOffset = self.domainOffset + 1
                    self.onFetchMyDomain(self.account!)
                } else {
                    self.onFetchFinished()
                }
                
            case .failure(let error):
                if (SHOW_LOG) { print("onFetchMyAccount ", error) }
                self.onFetchFinished()
            }
        }
        
    }
}