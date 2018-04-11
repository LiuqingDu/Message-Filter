//
//  MessageFilterExtension.swift
//  Message-Filter-Extension
//
//  Created by Liuqing Du on 2018/3/26.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import IdentityLookup
import Message_Filter_Framework

final class MessageFilterExtension: ILMessageFilterExtension {}

extension MessageFilterExtension: ILMessageFilterQueryHandling {
    
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        // First, check whether to filter using offline data (if possible).
        let offlineAction = self.offlineAction(for: queryRequest)
        
        switch offlineAction {
        case .allow, .filter:
            // Based on offline data, we know this message should either be Allowed or Filtered. Send response immediately.
            let response = ILMessageFilterQueryResponse()
            response.action = offlineAction
            
            completion(response)
            
        case .none:
            // Based on offline data, we do not know whether this message should be Allowed or Filtered. Defer to network.
            // Note: Deferring requests to network requires the extension target's Info.plist to contain a key with a URL to use. See documentation for details.
            context.deferQueryRequestToNetwork() { (networkResponse, error) in
                let response = ILMessageFilterQueryResponse()
                response.action = .none
                
                if let networkResponse = networkResponse {
                    // If we received a network response, parse it to determine an action to return in our response.
                    response.action = self.action(for: networkResponse)
                } else {
                    NSLog("Error deferring query request to network: \(String(describing: error))")
                }
                
                completion(response)
            }
        }
    }
    
    private func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> ILMessageFilterAction {
        
        // Replace with logic to perform offline check whether to filter first (if possible).
        // 读取已保存的过滤条件包
        let userDefaults = UserDefaults(suiteName: MessageFilterAppGroupName)
        let ruleString: String? = userDefaults?.object(forKey: MessageFilterExtensionRuleKey) as? String
        // 如果没有过滤条件则放行
        if (ruleString == nil) {
            return .allow
        }
        // 转换成过滤条件对象
        let rulePackage = FilterRulePackage.sharedInstance
        // 根据过滤条件包判断，如果匹配则过滤
        if (rulePackage.isUnwantedMessageBy(ILMessageFilterQueryRequest: queryRequest)) {
            return .filter
        }
        // 没有匹配上则放行
        return .allow
    }
    
    private func action(for networkResponse: ILNetworkResponse) -> ILMessageFilterAction {
        // Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
        return .none
    }
    
}
