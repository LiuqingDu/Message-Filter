//
//  QueryRequest.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/2.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import Foundation
import IdentityLookup

/// QueryRequest 简化类
/// 从系统的 ILMessageFilterQueryRequest 简化而来的类，包含发送者和信息内容

class QueryRequest: NSObject {
    public var sender: String = ""
    public var messageBody: String = ""
    
    override init() {
        super.init()
    }
    
    /// 初始化方法，通过系统的 ILMessageFilterQueryRequest 对象来创建
    ///
    /// - Parameter request: ILMessageFilterQueryRequest 对象
    init(withSystemQueryRequest request: ILMessageFilterQueryRequest){
        super.init()
        self.sender = request.sender!
        self.messageBody = request.messageBody!
    }
    
    /// 初始化方法，通过设置 sender 和 messageBody 来创建
    ///
    /// - Parameters:
    ///   - _sender: String, 发送者
    ///   - _messageBody: String, 信息内容
    init(withSender _sender: String, messageBody _messageBody: String){
        super.init()
        self.sender = _sender
        self.messageBody = _messageBody
    }
    
}
