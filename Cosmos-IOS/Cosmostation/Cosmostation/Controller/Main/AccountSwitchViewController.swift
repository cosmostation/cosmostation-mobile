//
//  AccountSwitchViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/22.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class AccountSwitchViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var resultDelegate: AccountSwitchDelegate?
    @IBOutlet weak var chainTableView: UITableView!
    @IBOutlet weak var accountTableView: UITableView!
    
    var selectedChain = 0;
    var selectedAccounts = Array<Account>()
    var toAddChain: ChainType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        self.selectedChain = BaseData.instance.getRecentChain()
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        self.accountTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.accountTableView.register(UINib(nibName: "AccountPopupCell", bundle: nil), forCellReuseIdentifier: "AccountPopupCell")
        self.accountTableView.register(UINib(nibName: "ManageAccountAddCell", bundle: nil), forCellReuseIdentifier: "ManageAccountAddCell")
        
        self.chainTableView.delegate = self
        self.chainTableView.dataSource = self
        self.chainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.chainTableView.register(UINib(nibName: "ManageChainCell", bundle: nil), forCellReuseIdentifier: "ManageChainCell")
        onRefechUserInfo()
        
        let dismissTap1 = UITapGestureRecognizer(target: self, action: #selector(tableTapped))
        self.accountTableView.backgroundView = UIView()
        self.chainTableView.backgroundView = UIView()
        self.accountTableView.backgroundView?.addGestureRecognizer(dismissTap1)
    }
    
    @objc public func tableTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.chainTableView.selectRow(at: IndexPath.init(item: selectedChain, section: 0), animated: false, scrollPosition: .middle)
    }
    
    func onRefechUserInfo() {
        let selectedChain = ChainType.SUPPRT_CHAIN()[selectedChain]
        self.selectedAccounts = BaseData.instance.selectAllAccountsByChain(selectedChain)
        self.selectedAccounts.sort{
            return $0.account_sort_order < $1.account_sort_order
        }
        self.accountTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == chainTableView) {
            return ChainType.SUPPRT_CHAIN().count
        } else {
            return selectedAccounts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == chainTableView) {
            let cell:ManageChainCell? = tableView.dequeueReusableCell(withIdentifier:"ManageChainCell") as? ManageChainCell
            let selectedChain = ChainType.SUPPRT_CHAIN()[indexPath.row]
            cell?.chainImg.isHidden = false
            cell?.chainName.isHidden = false
            cell?.chainAll.isHidden = true
            cell?.chainImg.image = WUtils.getChainImg(selectedChain)
            cell?.chainName.text = WUtils.getChainTitle2(selectedChain)
            return cell!
            
        } else {
            let account = selectedAccounts[indexPath.row]
            let cell:AccountPopupCell? = tableView.dequeueReusableCell(withIdentifier:"AccountPopupCell") as? AccountPopupCell
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
            
            cell?.cardView.borderColor = UIColor.init(hexString: "#9ca2ac")
            if (self.account?.account_id == account.account_id) {
                cell?.cardView.borderWidth = 1.0
            } else {
                cell?.cardView.borderWidth = 0.0
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == chainTableView && selectedChain != indexPath.row) {
            selectedChain = indexPath.row
            BaseData.instance.setRecentChain(selectedChain)
            self.onRefechUserInfo()
            
        } else if (tableView == accountTableView) {
            self.resultDelegate?.accountSelected(Int(selectedAccounts[indexPath.row].account_id))
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func onClickAddNew(_ sender: UIButton) {
        self.onShowSelectChainDialog()
    }
    
    override func onChainSelected(_ chainType: ChainType) {
        self.toAddChain = chainType
        if (BaseData.instance.selectAllAccountsByChain(toAddChain!).count >= MAX_WALLET_PER_CHAIN) {
            self.onShowToast(NSLocalizedString("error_max_account_number", comment: ""))
            
        } else {
            self.resultDelegate?.addAccount(toAddChain!)
            self.dismiss(animated: false, completion: nil)
        }
    }
}

protocol AccountSwitchDelegate {
    func accountSelected (_ id:Int)
    func addAccount(_ chain:ChainType)
}
