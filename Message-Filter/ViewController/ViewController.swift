//
//  ViewController.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/3/26.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import UIKit
import Message_Filter_Framework
import Font_Awesome_Swift
import RAMPaperSwitch

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btn_set: UIBarButtonItem!
    @IBOutlet weak var table_filterRuleGroup: UITableView!
    @IBOutlet weak var btn_add: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 设置按钮图标
        btn_set.FAIcon = FAType.FACog
        btn_add.FAIcon = FAType.FAPlus
        
        // 设置 TableView 的代理
        table_filterRuleGroup.delegate = self
        table_filterRuleGroup.dataSource = self
        
        // 注册 FilterRuleGroupCell
        table_filterRuleGroup.register(UINib(nibName: FilterRuleGroupCellIdentity, bundle: nil), forCellReuseIdentifier: FilterRuleGroupCellIdentity)
        
        // 使用自动计算高度
        table_filterRuleGroup.estimatedRowHeight = 85
        table_filterRuleGroup.rowHeight = UITableViewAutomaticDimension
        
        // 去除分割线
        table_filterRuleGroup.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table_filterRuleGroup.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterRulePackage.sharedInstance.blackFilterRuleGroup.count + FilterRulePackage.sharedInstance.whiteFilterRuleGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_filterRuleGroup.dequeueReusableCell(withIdentifier: FilterRuleGroupCellIdentity) as! FilterRuleGroupCell
        // 先加载 whiteFilterRuleList
        if (indexPath.row < FilterRulePackage.sharedInstance.whiteFilterRuleGroup.count) {
            cell.setIcon(UIImage(icon: FAType.FACheck, size: CGSize(width: 60, height: 60)))
            cell.setFilterRule(FilterRulePackage.sharedInstance.whiteFilterRuleGroup[indexPath.row].rules[0])
        } else {
            let n = FilterRulePackage.sharedInstance.whiteFilterRuleGroup.count
            cell.setIcon(UIImage(icon: FAType.FATimes, size: CGSize(width: 60, height: 60)))
            cell.setFilterRule(FilterRulePackage.sharedInstance.blackFilterRuleGroup[indexPath.row - n].rules[0])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("lalaala")
        let alert = UIAlertController(title: "编辑过滤条件", message: nil, preferredStyle: .actionSheet)
        alert.addAction(image: UIImage(icon: .FATrash, size: CGSize(width: 24, height: 24)), title: "删除", color: UIColor.flatRed(), style: .default, isEnabled: true) { (_) in
            let rulePackage = FilterRulePackage.sharedInstance
            let whiteSum = rulePackage.whiteFilterRuleGroup.count
            // 如果小于 whiteSum 则是白名单
            if indexPath.row < whiteSum {
                 rulePackage.whiteFilterRuleGroup.remove(at: indexPath.row)
            } else {
                rulePackage.blackFilterRuleGroup.remove(at: indexPath.row - whiteSum)
            }
            rulePackage.saveToUserDefault()
            self.table_filterRuleGroup.reloadData()
        }
        self.present(alert, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard (orientation == .right) else {return nil}
//        let deleteAction = SwipeAction(style: .destructive, title: "删除") { (action, indexPath) in
//            print("lalala")
//        }
//        deleteAction.image = UIImage(icon: FAType.FARemove, size: CGSize(width: 60, height: 60))
//
//        return [deleteAction]
//    }
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }

}

