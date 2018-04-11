//
//  AddRuleViewController.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/9.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import UIKit
import Message_Filter_Framework
import Font_Awesome_Swift

class AddRuleViewController: UITableViewController {
    
    private var rulePackage: FilterRulePackage!
    
    private var ruleTarget = FilterRuleTarget.FilterRuleTargetContent

    @IBOutlet weak var txt_ruleString: UITextView!
    @IBAction func addRule(_ sender: Any) {
        let filterRule = FilterRule(withRuleTarget: FilterRuleTarget.FilterRuleTargetContent, ruleType: FilterRuleType.FilterRuleTypeContains, keyword: txt_ruleString.text)
        let filterRuleGroup = FilterRuleGroup()
        filterRuleGroup.rules.append(filterRule)
        rulePackage = FilterRulePackage.sharedInstance
        rulePackage.blackFilterRuleGroup.append(filterRuleGroup)
        print(rulePackage.blackFilterRuleGroup.count)
        print(rulePackage.saveToUserDefault())
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 2:
            let alert = UIAlertController(title: "选择检测对象", message: "选择检测对象", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(image: UIImage(icon: .FAPhone, size: CGSize(width: 24, height: 24)), title: "发送者", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleTarget = .FilterRuleTargetSender
            }
            alert.addAction(image: UIImage(icon: .FAFileText, size: CGSize(width: 24, height: 24)), title: "信息内容", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleTarget = .FilterRuleTargetContent
            }
            alert.show()
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
