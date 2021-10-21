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
    
    var mSelectedChain = 0;
    var mSelectedAccounts = Array<Account>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mSelectedChain = BaseData.instance.getRecentChain()
        print("mSelectedChain ", mSelectedChain)
        
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        self.accountTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.accountTableView.register(UINib(nibName: "ManageAccountCell", bundle: nil), forCellReuseIdentifier: "ManageAccountCell")
        self.accountTableView.register(UINib(nibName: "ManageAccountAddCell", bundle: nil), forCellReuseIdentifier: "ManageAccountAddCell")
        
        self.chainTableView.delegate = self
        self.chainTableView.dataSource = self
        self.chainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.chainTableView.register(UINib(nibName: "ManageChainCell", bundle: nil), forCellReuseIdentifier: "ManageChainCell")
        self.onRefechUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_wallet_manage", comment: "");
        self.navigationItem.title = NSLocalizedString("title_wallet_manage", comment: "");
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "iconEdit"), style: .done, target: self, action: #selector(onStartEdit))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.chainTableView.selectRow(at: IndexPath.init(item: mSelectedChain, section: 0), animated: false, scrollPosition: .middle)
    }
    
    @objc public func onStartEdit() {
        print("onStartEdit")
    }
    
    func onRefechUserInfo() {
        let selectedChain = ChainType.SUPPRT_CHAIN()[mSelectedChain]
        self.mSelectedAccounts = BaseData.instance.selectAllAccountsByChain(selectedChain)
        self.sortWallet()
        self.accountTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == chainTableView) {
            return ChainType.SUPPRT_CHAIN().count
            
        } else if (tableView == accountTableView) {
            if (mSelectedAccounts.count < 5) {
                return mSelectedAccounts.count + 1
            } else {
                return mSelectedAccounts.count
            }
            
        } else {
            return 0
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
            if (mSelectedAccounts.count <= indexPath.row) {
                let cell:ManageAccountAddCell? = tableView.dequeueReusableCell(withIdentifier:"ManageAccountAddCell") as? ManageAccountAddCell
                return cell!
            }
            
            let account = mSelectedAccounts[indexPath.row]
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
        if (tableView == chainTableView) {
            if (mSelectedChain != indexPath.row) {
                mSelectedChain = indexPath.row
                BaseData.instance.setRecentChain(mSelectedChain)
                self.onRefechUserInfo()
            }
        } else {
            if (mSelectedAccounts.count <= indexPath.row) {
                let popupContent = AddViewController.create()
                let cardPopup = SBCardPopupViewController(contentViewController: popupContent)
                cardPopup.resultDelegate = self
                cardPopup.show(onViewController: self)
                
            } else {
                let walletDetailVC = WalletDetailViewController(nibName: "WalletDetailViewController", bundle: nil)
                walletDetailVC.hidesBottomBarWhenPushed = true
                walletDetailVC.accountId = self.mSelectedAccounts[indexPath.row].account_id
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(walletDetailVC, animated: true)
            }
        }
    }
    
    func sortWallet() {
        self.mSelectedAccounts.sort{
            return $0.account_sort_order < $1.account_sort_order
        }
    }
    
    func SBCardPopupResponse(type:Int, result: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(490), execute: {
            var tagetVC:BaseViewController?
            if(result == 1) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
                tagetVC?.chainType = ChainType.SUPPRT_CHAIN()[self.mSelectedChain - 1]
                
            } else if(result == 2) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "RestoreViewController") as! RestoreViewController
                tagetVC?.chainType = ChainType.SUPPRT_CHAIN()[self.mSelectedChain - 1]
                
            } else if(result == 3) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
                
            }
            if(tagetVC != nil) {
                tagetVC?.hidesBottomBarWhenPushed = true
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(tagetVC!, animated: true)
            }
        })
    }
}

/*
class WalletManageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate, SBCardPopupDelegate {

    @IBOutlet weak var chainTableView: UITableView!
    @IBOutlet weak var accountTableView: UITableView!

    var mSelectedAccounts = Array<Account>()
    var mSelectedChain = 0;
    var isEditMode = false;

    override func viewDidLoad() {
        super.viewDidLoad()

        mSelectedChain = BaseData.instance.getRecentChain()

        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        self.accountTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.accountTableView.register(UINib(nibName: "ManageAccountCell", bundle: nil), forCellReuseIdentifier: "ManageAccountCell")
        self.accountTableView.register(UINib(nibName: "ManageAccountAddCell", bundle: nil), forCellReuseIdentifier: "ManageAccountAddCell")
        self.accountTableView.dragDelegate = self
        self.accountTableView.dropDelegate = self

        self.chainTableView.delegate = self
        self.chainTableView.dataSource = self
        self.chainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.chainTableView.register(UINib(nibName: "ManageChainCell", bundle: nil), forCellReuseIdentifier: "ManageChainCell")
        self.onRefechUserInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_wallet_manage", comment: "");
        self.navigationItem.title = NSLocalizedString("title_wallet_manage", comment: "");
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.chainTableView.selectRow(at: IndexPath.init(item: mSelectedChain, section: 0), animated: false, scrollPosition: .middle)
    }

    func updateOptionBtn() {
        if (mSelectedChain == 0 && isEditMode) {
            let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "finishBtn"), style: .done, target: self, action: #selector(onStopEdit))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        } else if (mSelectedChain == 0 && !isEditMode) {
            let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "sortingBtn"), style: .done, target: self, action: #selector(onStartEdit))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    @objc public func onStartEdit() {
        self.isEditMode = true
        self.accountTableView.reloadData()
        self.updateOptionBtn()
        self.accountTableView.dragInteractionEnabled = true
    }

    @objc public func onStopEdit() {
        self.isEditMode = false
        self.accountTableView.reloadData()
        self.updateOptionBtn()
        self.accountTableView.dragInteractionEnabled = false
    }

    func onRefechUserInfo() {
        if (mSelectedChain == 0) {
            self.mSelectedAccounts = BaseData.instance.selectAllAccounts()
        } else {
            let selectedChain = ChainType.SUPPRT_CHAIN()[mSelectedChain - 1]
            self.mSelectedAccounts = BaseData.instance.selectAllAccountsByChain(selectedChain)
        }
        self.sortWallet()
        self.accountTableView.reloadData()
        self.updateOptionBtn()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == chainTableView) {
            return ChainType.SUPPRT_CHAIN().count + 1

        } else {
            if (mSelectedChain == 0) {
                return mSelectedAccounts.count
            } else {
                if (mSelectedAccounts.count < 5) {
                    return mSelectedAccounts.count + 1
                } else {
                    return mSelectedAccounts.count
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == chainTableView) {
            let cell:ManageChainCell? = tableView.dequeueReusableCell(withIdentifier:"ManageChainCell") as? ManageChainCell
            if (indexPath.row == 0) {
                cell?.chainImg.isHidden = true
                cell?.chainName.isHidden = true
                cell?.chainAll.isHidden = false

            } else {
                let selectedChain = ChainType.SUPPRT_CHAIN()[indexPath.row - 1]
                cell?.chainImg.isHidden = false
                cell?.chainName.isHidden = false
                cell?.chainAll.isHidden = true
                cell?.chainImg.image = WUtils.getChainImg(selectedChain)
                cell?.chainName.text = WUtils.getChainTitle2(selectedChain)
            }
            return cell!

        } else {
            if (mSelectedAccounts.count <= indexPath.row) {
                let cell:ManageAccountAddCell? = tableView.dequeueReusableCell(withIdentifier:"ManageAccountAddCell") as? ManageAccountAddCell
                return cell!
            }

            let account = mSelectedAccounts[indexPath.row]
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
            if (isEditMode) {
                cell?.arrowImg.image = UIImage(named: "changeIc")
                cell?.arrowConstraint.constant = 10
                cell?.arrowConstraint2.constant = 10
                cell?.arrowConstraint3.constant = 10
            } else {
                cell?.arrowImg.image = UIImage(named: "arrowNextGr")
                cell?.arrowConstraint.constant = 4
                cell?.arrowConstraint2.constant = 4
                cell?.arrowConstraint3.constant = 4
            }
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == chainTableView) {
            if (mSelectedChain != indexPath.row) {
                mSelectedChain = indexPath.row
                BaseData.instance.setRecentChain(mSelectedChain)
                self.isEditMode = false
                self.onRefechUserInfo()
            }
        } else if (!isEditMode) {
            if (mSelectedAccounts.count <= indexPath.row) {
                let popupContent = AddViewController.create()
                let cardPopup = SBCardPopupViewController(contentViewController: popupContent)
                cardPopup.resultDelegate = self
                cardPopup.show(onViewController: self)

            } else {
                let walletDetailVC = WalletDetailViewController(nibName: "WalletDetailViewController", bundle: nil)
                walletDetailVC.hidesBottomBarWhenPushed = true
                walletDetailVC.accountId = self.mSelectedAccounts[indexPath.row].account_id
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(walletDetailVC, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear
        return param
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: self.mSelectedAccounts[indexPath.row])
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath,
            let sourceIndexPath = coordinator.items[0].sourceIndexPath else{
            return
        }
        let sourceItem = self.mSelectedAccounts[sourceIndexPath.row]
        self.mSelectedAccounts.remove(at: sourceIndexPath.row)
        self.mSelectedAccounts.insert(sourceItem, at: destinationIndexPath.row)
        DispatchQueue.main.async {
            for i in 0 ... (self.mSelectedAccounts.count - 1) {
                self.mSelectedAccounts[i].account_sort_order = Int64(i)
            }
            BaseData.instance.updateSortOrder(self.mSelectedAccounts)
            self.accountTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Account.self)
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    func sortWallet() {
        self.mSelectedAccounts.sort{
            return $0.account_sort_order < $1.account_sort_order
        }
    }

    func SBCardPopupResponse(type:Int, result: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(490), execute: {
            var tagetVC:BaseViewController?
            if(result == 1) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
                tagetVC?.chainType = ChainType.SUPPRT_CHAIN()[self.mSelectedChain - 1]

            } else if(result == 2) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "RestoreViewController") as! RestoreViewController
                tagetVC?.chainType = ChainType.SUPPRT_CHAIN()[self.mSelectedChain - 1]

            } else if(result == 3) {
                tagetVC = UIStoryboard(name: "Init", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController

            }
            if(tagetVC != nil) {
                tagetVC?.hidesBottomBarWhenPushed = true
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(tagetVC!, animated: true)
            }
        })
    }
}
*/
