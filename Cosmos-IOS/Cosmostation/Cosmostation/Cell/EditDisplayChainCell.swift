//
//  EditDisplayChainCell.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/10/25.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class EditDisplayChainCell: UITableViewCell {

    @IBOutlet weak var chainImgView: UIImageView!
    @IBOutlet weak var chainTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    var actionRemoveChain: (() -> Void)? = nil
    @IBAction func onClickRemoveChain(_ sender: UIButton) {
        actionRemoveChain?()
    }
}
