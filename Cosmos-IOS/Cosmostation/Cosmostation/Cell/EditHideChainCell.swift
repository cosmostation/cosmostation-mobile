//
//  EditHideChainCell.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/25.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class EditHideChainCell: UITableViewCell {
    
    @IBOutlet weak var chainImgView: UIImageView!
    @IBOutlet weak var chainTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    var actionAddChain: (() -> Void)? = nil
    @IBAction func onClickAddChain(_ sender: UIButton) {
        actionAddChain?()
    }
}
