//
//  Networking.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//  实现NetworkingType 协议的具体类，

import Foundation
import Moya


/*!
 Github接口
 */
struct GitHubNetworking : NetworkingType {
    
    typealias T = GithubAPI
    
    let provider: MoyaProvider<T>
    
    static func defaultNetworking() -> GitHubNetworking {
        return GitHubNetworking(provider: MoyaProvider<T>())
    }
    
    
}


