//
//  GithubAPI.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//

import Foundation
import Moya



enum GithubAPI {
    case apiSummery
    
    
    
}


extension GithubAPI : TargetType {
    var baseURL: URL {
        return try! Configs.Network.githubBaseUrl.asURL()
    }
    
    var path: String {
        switch self {
        case .apiSummery: return ""
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    
    var parameters:[String:Any]? {
        var params:[String:Any] = [:]
        switch self {
        case .apiSummery: break;
        }
        return params
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return .requestPlain
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
