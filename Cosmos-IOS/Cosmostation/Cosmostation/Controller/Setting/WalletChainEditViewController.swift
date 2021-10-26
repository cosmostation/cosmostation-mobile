//
//  WalletChainEditViewController.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/25.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class WalletChainEditViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    
    @IBOutlet weak var displayingChainTableView: UITableView!
    @IBOutlet weak var hideChainTableView: UITableView!
    
    var allChains = Array<ChainType>()
    var displayedChains = Array<ChainType>()
    var hidedChains = Array<ChainType>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = BaseData.instance.selectAccountById(id: BaseData.instance.getRecentAccountId())
        
        self.displayingChainTableView.delegate = self
        self.displayingChainTableView.dataSource = self
        self.displayingChainTableView.dragDelegate = self
        self.displayingChainTableView.dropDelegate = self
        self.displayingChainTableView.dragInteractionEnabled = true
        self.displayingChainTableView.register(UINib(nibName: "EditDisplayChainCell", bundle: nil), forCellReuseIdentifier: "EditDisplayChainCell")
        
        self.hideChainTableView.delegate = self
        self.hideChainTableView.dataSource = self
        self.hideChainTableView.register(UINib(nibName: "EditHideChainCell", bundle: nil), forCellReuseIdentifier: "EditHideChainCell")
        
        allChains = Array(ChainType.SUPPRT_CHAIN().dropFirst())
        displayedChains = BaseData.instance.userSortedChains()
        hidedChains = BaseData.instance.userHideChains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("title_edit_chain", comment: "");
        self.navigationItem.title = NSLocalizedString("title_edit_chain", comment: "");
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onEndEdit))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.onSaveUserChains()
    }
    
    
    @objc public func onEndEdit() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func onSaveUserChains() {
        BaseData.instance.setUserHiddenChains(hidedChains)
        BaseData.instance.setUserSortedChains(displayedChains)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == displayingChainTableView) {
            return displayedChains.count
        } else if (tableView == hideChainTableView) {
            return hidedChains.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == displayingChainTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier:"EditDisplayChainCell") as? EditDisplayChainCell
            let chainType = displayedChains[indexPath.row]
            cell?.chainImgView.image = WUtils.getChainImg(chainType)
            cell?.chainTitleLabel.text = WUtils.getChainTitle2(chainType)
            cell?.actionRemoveChain = { self.onClickRemoveChain(chainType) }
            cell?.selectionStyle = .none
            return cell!
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"EditHideChainCell") as? EditHideChainCell
            let chainType = hidedChains[indexPath.row]
            cell?.chainImgView.image = WUtils.getChainImg(chainType)
            cell?.chainTitleLabel.text = WUtils.getChainTitle2(chainType)
            cell?.actionAddChain = { self.onClickAddChain(chainType) }
            return cell!
        }
    }
    
    func onClickAddChain(_ chainType: ChainType) {
        if let hideChainIndex = hidedChains.firstIndex { $0 == chainType } {
            hidedChains.remove(at: hideChainIndex)
            displayedChains.append(chainType)
            
            displayingChainTableView.reloadData()
            hideChainTableView.reloadData()
        }
    }
    
    func onClickRemoveChain(_ chainType: ChainType) {
        if (BaseData.instance.selectAllAccountsByChain(ChainType.COSMOS_MAIN).count <= 0) {
            var dpAccoutnSum = 0
            displayedChains.forEach { chain in
                if (chain != chainType) {
                    let accountNum = BaseData.instance.selectAllAccountsByChain(chain)
                    dpAccoutnSum = dpAccoutnSum + accountNum.count
                }
            }
            if (dpAccoutnSum <= 0) {
                self.onShowToast(NSLocalizedString("error_reserve_1_account", comment: ""))
                return 
            }
        }
        
        if let displayChainIndex = displayedChains.firstIndex { $0 == chainType } {
            displayedChains.remove(at: displayChainIndex)
            hidedChains.append(chainType)
            var tempHide = Array<ChainType>()
            allChains.forEach { chain in
                if (hidedChains.contains(chain) == true) {
                    tempHide.append(chain)
                }
            }
            hidedChains = tempHide
            
            displayingChainTableView.reloadData()
            hideChainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: self.account!)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath,
              let sourceIndexPath = coordinator.items[0].sourceIndexPath else {
            return
        }
        let sourceItem = self.displayedChains[sourceIndexPath.row]
        self.displayedChains.remove(at: sourceIndexPath.row)
        self.displayedChains.insert(sourceItem, at: destinationIndexPath.row)
        DispatchQueue.main.async {
            self.displayingChainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Account.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
