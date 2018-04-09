//
//  ViewController.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/3/26.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import UIKit
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_filterRuleGroup.dequeueReusableCell(withIdentifier: FilterRuleGroupCellIdentity) as! FilterRuleGroupCell
        //cell.delegate = self
        cell.setIcon(icon: UIImage(icon: FAType.FAGithub, size: CGSize(width: 60, height: 60)))
        return cell
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

