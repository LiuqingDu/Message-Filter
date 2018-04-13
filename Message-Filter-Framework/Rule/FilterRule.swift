//
//  FilterRule.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/2.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import Foundation

/// 过滤规则的目标
///
/// - FilterRuleTargetSender: 发送者
/// - FilterRuleTargetContent: 消息内容
public enum FilterRuleTarget: String, Codable {
    case FilterRuleTargetSender = "FilterRuleTargetSender"
    case FilterRuleTargetContent = "FilterRuleTargetContent"
}

/// 过滤规则的类型
///
/// - FilterRuleTypePrefix: 前缀包含
/// - FilterRuleTypeSuffix: 后缀包含
/// - FilterRuleTypeContains: 包含
/// - FilterRuleTypeNotContains: 不包含
/// - FilterRuleTypeRegex: 正则表达式
public enum FilterRuleType: String, Codable {
    case FilterRuleTypePrefix = "FilterRuleTypePrefix"
    case FilterRuleTypeSuffix = "FilterRuleTypeSuffix"
    case FilterRuleTypeContains = "FilterRuleTypeContains"
    case FilterRuleTypeNotContains = "FilterRuleTypeNotContains"
    case FilterRuleTypeRegex = "FilterRuleTypeRegex"
}

/// 过滤规则的执行方式
///
/// - FilterRuleActionBlock: 过滤
/// - FilterRuleActionAllow: 放行
public enum FilterRuleAction: String, Codable {
    case FilterRuleActionBlock = "FilterRuleActionBlock"
    case FilterRuleActionAllow = "FilterRuleActionAllow"
}

/// 过滤规则
public class FilterRule: NSObject, Codable {
    
    public var ruleTarget: FilterRuleTarget = .FilterRuleTargetContent
    public var ruleType  : FilterRuleType = .FilterRuleTypeContains
    public var keyword   : String = ""
    
    public init(withRuleTarget _ruleTarget: FilterRuleTarget, ruleType _ruleType: FilterRuleType, keyword _keyword: String){
        self.ruleType = _ruleType
        self.ruleTarget = _ruleTarget
        self.keyword = _keyword
    }
    
    /// 判断输入的 QueryRequest 是否符合过滤条件
    ///
    /// - Parameter request: 待检查的 QueryRequest
    /// - Returns: 是否符合条件。匹配上返回trle，没匹配上返回false。
    public func isMachedForRequest(request: QueryRequest) -> Bool {
        // 检测的对象。可以是：1，发送人；2，发送内容
        // 根据过滤条件设置的检测对象来获取相应的待检测内容
        var target: String
        switch self.ruleTarget {
        case .FilterRuleTargetSender:
            target = request.sender
        case .FilterRuleTargetContent:
            target = request.messageBody
        }
        
        // 如果待检测内容为空，则返回 false ，没有匹配上
        if (target.count < 1) {
            return false
        }
        
        // 返回的结果
        var result = false
        
        // 检测的方式
        // 根据过滤条件设置的检测方式来对待检测内容进行匹配
        switch self.ruleType {
        case .FilterRuleTypePrefix:
            result = target.hasPrefix(self.keyword)
        case .FilterRuleTypeSuffix:
            result = target.hasSuffix(self.keyword)
        case .FilterRuleTypeContains:
            result = target.contains(self.keyword)
        case .FilterRuleTypeNotContains:
            result = !target.contains(self.keyword)
        case .FilterRuleTypeRegex:
            //TODO: - 正则表达式过滤方式需确认
            let regex = try? NSRegularExpression(pattern: self.keyword, options: .caseInsensitive)
            result = (regex!.numberOfMatches(in: target, options: .reportCompletion, range: NSRange(location: 0, length: target.count)) != 0)
        }
        return result
    }
    
}
