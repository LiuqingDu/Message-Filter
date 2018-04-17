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
import Message_Filter_Framework

class FilterRuleGroupCell: UITableViewCell {

    @IBOutlet weak var switch_ruleActive: RAMPaperSwitch!
    @IBOutlet weak var image_icon: UIImageView!
    @IBOutlet weak var label_rule: UILabel!
    @IBOutlet weak var label_ruleTarget: UILabel!
    @IBOutlet weak var label_ruleType: UILabel!
    
    public func setFilterRule(_ filterRule: FilterRule){
        label_rule.text = filterRule.keyword
        label_ruleTarget.text = NSLocalizedString(filterRule.ruleTarget.rawValue, comment: "")
        label_ruleType.text = NSLocalizedString(filterRule.ruleType.rawValue, comment: "")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switch_ruleActive.onTintColor = UIColor.init(randomFlatColorOf: .light)
        switch_ruleActive.duration = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setIcon(_ icon: UIImage) {
        image_icon.image = icon
    }
    
}
