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
    
    // 默认过滤信息内容
    private var ruleTarget = FilterRuleTarget.FilterRuleTargetContent
    // 默认过滤方式是包含
    private var ruleType = FilterRuleType.FilterRuleTypeContains
    // 默认过滤操作是阻拦
    private var ruleAction = FilterRuleAction.FilterRuleActionBlock

    @IBOutlet weak var txt_ruleString: UITextView!
    @IBAction func addRule(_ sender: Any) {
        let filterRule = FilterRule(withRuleTarget: ruleTarget, ruleType: ruleType, keyword: txt_ruleString.text)
        let filterRuleGroup = FilterRuleGroup()
        filterRuleGroup.rules.append(filterRule)
        rulePackage = FilterRulePackage.sharedInstance
        if (ruleAction == .FilterRuleActionAllow) {
            rulePackage.whiteFilterRuleGroup.append(filterRuleGroup)
        } else {
            rulePackage.blackFilterRuleGroup.append(filterRuleGroup)
        }
        print(rulePackage.saveToUserDefault())
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            // 选择检测对象
        case 2:
            let alert = UIAlertController(title: "选择检测对象", message: nil, preferredStyle: .actionSheet)
            alert.addAction(image: UIImage(icon: .FAPhone, size: CGSize(width: 24, height: 24)), title: "发送者", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleTarget = .FilterRuleTargetSender
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "发送者"
            }
            alert.addAction(image: UIImage(icon: .FACommentO, size: CGSize(width: 24, height: 24)), title: "信息内容", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleTarget = .FilterRuleTargetContent
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "信息内容"
            }
            self.present(alert, animated: true, completion: nil)
        case 3:
            let alert = UIAlertController(title: "选择检测规则", message: nil, preferredStyle: .actionSheet)
            alert.addAction(image: UIImage(icon: .FAAlignLeft, size: CGSize(width: 24, height: 24)), title: "前缀包含", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleType = .FilterRuleTypePrefix
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "前缀包含"
            }
            alert.addAction(image: UIImage(icon: .FAAlignRight, size: CGSize(width: 24, height: 24)), title: "后缀包含", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleType = .FilterRuleTypeSuffix
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "后缀包含"
            }
            alert.addAction(image: UIImage(icon: .FAAlignJustify, size: CGSize(width: 24, height: 24)), title: "包含", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleType = .FilterRuleTypeContains
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "包含"
            }
            alert.addAction(image: UIImage(icon: .FAAlignCenter, size: CGSize(width: 24, height: 24)), title: "不包含", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleType = .FilterRuleTypeNotContains
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "不包含"
            }
            alert.addAction(image: UIImage(icon: .FAFont, size: CGSize(width: 24, height: 24)), title: " 正则表达式", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleType = .FilterRuleTypeRegex
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "正则表达式"
            }
            self.present(alert, animated: true, completion: nil)
        case 4:
            let alert = UIAlertController(title: "选择过滤方式", message: nil, preferredStyle: .actionSheet)
            alert.addAction(image: UIImage(icon: .FACheck, size: CGSize(width: 24, height: 24)), title: "放行", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleAction = .FilterRuleActionAllow
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "放行"
            }
            alert.addAction(image: UIImage(icon: .FATimes, size: CGSize(width: 24, height: 24)), title: " 过滤", color: nil, style: .default, isEnabled: true) { (_) in
                self.ruleAction = .FilterRuleActionBlock
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "过滤"
            }
            self.present(alert, animated: true, completion: nil)
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
