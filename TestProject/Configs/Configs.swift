//
//  Configs.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//

import Foundation

struct Configs {
    
    
    // MARK: - Network
    struct Network {
        
        // 请求接口baseUrl
        static let githubBaseUrl: String = "https://api.github.com"
        // 日志开启
        static let logEnabled = false
        
        
    }
    
    // MARK : - 常量 Const
    struct Const {
        
        static let cellDefaultHeight = 44.0
    }
    
    
    // MARK : - UserDefaultKey
    
    struct UserDefaultKey {
        
        static let getLatestDataKey = ""
    }
    
    
    
}
