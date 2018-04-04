//
//  FilterRuleGroup.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/3.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import Foundation

/// 过滤条件组
/// 包含一个过滤条件数组
/// 一个方法检查传入的 QueryRequest 是否匹配过滤条件组
class FilterRuleGroup: NSObject {
    
    public var rules = Array<FilterRule>()
    
    /// 判断输入的 QueryRequest 是否匹配过滤条件组
    ///
    /// - Parameter request: 待检查的 QueryRequest
    /// - Returns: 是否匹配。匹配返回true，不匹配返回false。
    public func isMatchedForRequest(request: QueryRequest) -> Bool {
        for filterRule in self.rules {
            if filterRule.isMachedForRequest(request: request) {
                return true
            }
        }
        return false
    }
    
}
