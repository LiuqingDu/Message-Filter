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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btn_set.FAIcon = FAType.FACog
        table_filterRuleGroup.delegate = self
        table_filterRuleGroup.dataSource = self
        table_filterRuleGroup.register(UINib(nibName: "FilterRuleGroupCell", bundle: nil), forCellReuseIdentifier: "FilterRuleGroupCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = table_filterRuleGroup.dequeueReusableCell(withIdentifier: "FilterRuleGroupCell") as! FilterRuleGroupCell
        return (cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_filterRuleGroup.dequeueReusableCell(withIdentifier: "FilterRuleGroupCell") as! FilterRuleGroupCell
        cell.setIcon(icon: UIImage(icon: FAType.FAGithub, size: CGSize(width: 60, height: 60)))
        return cell
    }

}

