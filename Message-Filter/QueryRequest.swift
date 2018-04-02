//
//  QueryRequest.swift
//  Message-Filter
//
//  Created by Liuqing Du on 2018/4/2.
//  Copyright © 2018年 JuneDesign. All rights reserved.
//

import Foundation
import IdentityLookup

class QueryRequest: NSObject {
    var sender: String?
    var messageBody: String?
    
    override init() {
        super.init()
        
    }
    
    init(withSystemQueryRequest request: ILMessageFilterQueryRequest){
        super.init()
        self.sender = request.sender
        self.messageBody = request.messageBody
    }
    
    init(withSender _sender: String, _messageBody: String){
        super.init()
        self.sender = _sender
        self.messageBody = _messageBody
    }
    
}
