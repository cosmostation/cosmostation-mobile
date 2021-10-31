//
//  WalletManageViewController.swift
//  Cosmostation
//
//  Created by yongjoo on 03/04/2019.
//  Copyright © 2019 wannabit. All rights reserved.
//

import UIKit
import Alamofire

class WalletManageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SBCardPopupDelegate {
    
    @IBOutlet weak var chainTableView: UITableView!
    @IBOutlet weak var accountTableView: UITableView!
    
    var displayChains = Array<ChainType>()
    var displayAccounts = Array<Account>()
    var selectedChain: ChainType!
    var toAddChain: ChainType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        self.accountTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.accountTableView.register(UINib(nibName: "ManageAccountCell", bundle: nil), forCellReuseIdentifier: "ManageAccountCell")
        
        self.chainTableView.delegate = self
        self.chainTableView.dataSource = self
        self.chainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.chainTableView.register(UINib(nibName: "ManageChainCell", bundle: nil), forCellReuseIdentifier: "ManageChainCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_wallet_manage", comment: "");
        self.navigationItem.title = NSLocalizedString("title_wallet_manage", comment: "");
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(onStartEdit))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.onRefechUserInfo()
    }
    
    @objc public func onStartEdit() {
        let walletEditVC = WalletChainEditViewController(nibName: "WalletChainEditViewController", bundle: nil)
        walletEditVC.hidesBottomBarWhenPushed = true
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(walletEditVC, animated: true)
    }
    
    func onRefechUserInfo() {
        self.displayChains = BaseData.instance.dpSortedChains()
        self.selectedChain = BaseData.instance.getRecentChain()
        self.displayAccounts = BaseData.instance.selectAllAccountsByChain(selectedChain)
        self.sortWallet()
        self.chainTableView.reloadData()
        self.accountTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == chainTableView) {
            return displayChains.count
        } else if (tableView == accountTableView) {
            return displayAccounts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == chainTableView) {
            let cell:ManageChainCell? = tableView.dequeueReusableCell(withIdentifier:"ManageChainCell") as? ManageChainCell
            let selected = displayChains[indexPath.row]
            cell?.chainImg.image = WUtils.getChainImg(selected)
            cell?.chainName.text = WUtils.getChainTitle2(selected)
            if (selected == selectedChain) { cell?.onSetView(true) }
            else { cell?.onSetView(false) }
            return cell!
            
        } else {
            let account = displayAccounts[indexPath.row]
            let cell:ManageAccountCell? = tableView.dequeueReusableCell(withIdentifier:"ManageAccountCell") as? ManageAccountCell
            let userChain = WUtils.getChainType(account.account_base_chain)
            if (account.account_has_private) {
                cell?.keyImg.image = cell?.keyImg.image!.withRenderingMode(.alwaysTemplate)
                cell?.keyImg.tintColor = WUtils.getChainColor(userChain)
            } else {
                cell?.keyImg.tintColor = COLOR_DARK_GRAY
            }
            cell?.nameLabel.text = WUtils.getWalletName(account)
            var address = account.account_address
            if (userChain == ChainType.OKEX_MAIN || userChain == ChainType.OKEX_TEST) {
                address = WKey.convertAddressOkexToEth(address)
            }
            cell?.address.text = address
            cell?.amount.attributedText = WUtils.displayAmount2(account.account_last_total, cell!.amount.font, 0, 6)
            WUtils.setDenomTitle(userChain, cell!.amountDenom)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == chainTableView ) {
            selectedChain = displayChains[indexPath.row]
            BaseData.instance.setRecentChain(selectedChain)
            self.onRefechUserInfo()
            
        } else if (tableView == accountTableView) {
            let walletDetailVC = WalletDetailViewController(nibName: "WalletDetailViewController", bundle: nil)
            walletDetailVC.hidesBottomBarWhenPushed = true
            walletDetailVC.accountId = self.displayAccounts[indexPath.row].account_id
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(walletDetailVC, animated: true)
        }
    }
    
    func sortWallet() {
        self.displayAccounts.sort{
            return $0.account_sort_order < $1.account_sort_order
        }
    }
    
    func SBCardPopupResponse(type:Int, result: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(490), execute: {
            var tagetVC:BaseViewController?
            if (result == 1) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
                tagetVC?.chainType = self.toAddChain!
                
            } else if (result == 2) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "RestoreViewController") as! RestoreViewController
                tagetVC?.chainType = self.toAddChain!
                
            } else if (result == 3) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
                
            } else if (result == 4) {
                
            }
            if (tagetVC != nil) {
                tagetVC?.hidesBottomBarWhenPushed = true
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(tagetVC!, animated: true)
            }
        })
    }
    
    @IBAction func onClickAddNew(_ sender: UIButton) {
        self.onShowSelectChainDialog()
    }
    
    override func onChainSelected(_ chainType: ChainType) {
        self.toAddChain = chainType
        if (BaseData.instance.selectAllAccountsByChain(toAddChain!).count >= MAX_WALLET_PER_CHAIN) {
            self.onShowToast(NSLocalizedString("error_max_account_number", comment: ""))
            
        } else {let popupVC = NewAccountTypePopup(nibName: "NewAccountTypePopup", bundle: nil)
            let cardPopup = SBCardPopupViewController(contentViewController: popupVC)
            cardPopup.resultDelegate = self
            cardPopup.show(onViewController: self)
        }
    }
    
}
