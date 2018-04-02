//
//  FilterRule.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/2.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import Foundation

enum FilterRuleTarget: Int {
    case FilterRuleTargetSender = 0,
    FilterRuleTargetContent
}

enum FilterRuleType: Int {
    case FilterRuleTypePrefix = 0,
    FilterRuleTypeSuffix,
    FilterRuleTypeContains,
    FilterRuleTypeNotContains,
    FilterRuleTypeRegex
}

class FilterRule: NSObject {
    
    var ruleTarget: FilterRuleTarget?
    var ruleType  : FilterRuleType?
    var keyword   : String?
    
    override init() {
        super.init()
        
    }
    
//    public Bool isMachedForRequest(request: QueryRequest){
//    
//    }
    
}
