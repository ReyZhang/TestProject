//
//  Api.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//  对外开放的api使用接口， 

import Foundation
import RxSwift


protocol ApiService {
    func apiSummery() -> Observable<Any>
    
}

class Api: ApiService {
    
    let githubProvider:GitHubNetworking
    
    static let `default` = Api()
    
    init() {
        githubProvider = GitHubNetworking.defaultNetworking()
    }
    
}



extension Api {
    
    func apiSummery() -> Observable<Any> {
        self.githubProvider.request(.apiSummery)
    }
}
