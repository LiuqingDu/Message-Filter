//
//  FilterRulePackage.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/4.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import Foundation
import IdentityLookup

class FilterRulePackage: NSObject {
    
    public var whiteFilterRuleGroup = Array<FilterRuleGroup>()
    public var blackFilterRuleGroup = Array<FilterRuleGroup>()
    
    /// 单例
    public static var sharedInstance: FilterRulePackage {
        let userDefaults = UserDefaults(suiteName: MessageFilterAppGroupName)
        let ruleString = userDefaults?.object(forKey: MessageFilterExtensionRuleKey)
        let instance = FilterRulePackage.yy_model(withJSON: ruleString ?? "")
        return (instance == nil) ? FilterRulePackage() : instance!
    }
    
    /// 判断是不是垃圾信息
    ///
    /// - Parameter _request: ILMessageFilterQueryRequest
    /// - Returns: 是否是垃圾信息。如果匹配白名单则返回否，如果匹配黑名单则返回是，均不匹配返回否。
    public func isUnwantedMessageBy(ILMessageFilterQueryRequest _request: ILMessageFilterQueryRequest) -> Bool {
        let request = QueryRequest.init(withSystemQueryRequest: _request)
        
        for filterRuleGroup in self.whiteFilterRuleGroup {
            if filterRuleGroup.isMatchedForRequest(request: request) {
                return false
            }
        }
        
        for filterRuleGroup in self.blackFilterRuleGroup {
            if filterRuleGroup.isMatchedForRequest(request: request) {
                return true
            }
        }
        
        return false
    }
    
    /// 保存到本地 UserDefaults
    ///
    /// - Returns: 是否保存成功。返回否是因为没有可保存数据
    public static func saveToUserDefault() -> Bool {
        let ruleString = self.yy_modelToJSONString()
        if (ruleString == nil) {
            return false
        }
        let userDefaults = UserDefaults(suiteName: MessageFilterAppGroupName)
        userDefaults?.set(ruleString, forKey: MessageFilterExtensionRuleKey)
        return true
    }
    
}

