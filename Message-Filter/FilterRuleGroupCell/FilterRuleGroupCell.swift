//
//  FilterRuleGroupCell.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/6.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import UIKit
import ChameleonFramework
import RAMPaperSwitch

class FilterRuleGroupCell: UITableViewCell {

    @IBOutlet weak var switch_ruleActive: RAMPaperSwitch!
    @IBOutlet weak var image_icon: UIImageView!
    @IBOutlet weak var label_rule: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switch_ruleActive.onTintColor = UIColor.randomFlat()
        let size = label_rule.sizeThatFits(CGSize(width: label_rule.frame.size.width, height: CGFloat(MAXFLOAT)))
        label_rule.frame = CGRect(x: label_rule.frame.origin.x, y: label_rule.frame.origin.y, width: label_rule.frame.size.width, height: size.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setIcon(icon: UIImage) {
        image_icon.image = icon
    }
    
}
