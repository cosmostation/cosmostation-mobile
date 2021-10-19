//
//  WalletSifIncentiveCell.swift
//  Cosmostation
//
//  Created by 정용주 on 2021/06/22.
//  Copyright © 2021 wannabit. All rights reserved.
//

import UIKit

class WalletSifIncentiveCell: UITableViewCell {
    @IBOutlet weak var currentLmAmount: UILabel!
    @IBOutlet weak var maxDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        currentLmAmount.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: Font_13_footnote)
        maxDate.font = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: Font_11_caption2)
        
        currentLmAmount.attributedText = WUtils.displayAmount2("0", currentLmAmount.font, 0, 6)
        maxDate.text = "--"
    }
    
    func updateView(_ account: Account?, _ chainType: ChainType?) {
        let baseData = BaseData.instance
        if let lmCurrentAmount = baseData.mSifLmIncentive?.user?.totalClaimableCommissionsAndClaimableRewards {
            currentLmAmount.attributedText = WUtils.displayAmount2(String(lmCurrentAmount), currentLmAmount.font, 0, 6)
        }
        if let finishDate = baseData.mSifLmIncentive?.user?.maturityDateISO {
            maxDate.text = WUtils.sifNodeTimeToString(finishDate)
        }
    }
    
    var actionGetIncentive: (() -> Void)? = nil
    @IBAction func onClickIncentive(_ sender: Any) {
        actionGetIncentive?()
    }
}
