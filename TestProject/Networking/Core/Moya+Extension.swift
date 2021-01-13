//
//  Moya+Extension.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//

import Foundation
import Moya
import RxSwift
import HandyJSON

//扩展RxSwift的 ObservableType
extension ObservableType where Element == Response {
    
    func mapModel<T:HandyJSON>(_ type:T.Type) -> Observable<T> {
        return flatMap { (response) -> Observable<T> in
            return Observable.just(try! response.mapModel(type.self))
        }
    }
    
}

//扩展Moya框架的Response响应对象，添加数据转模型功能
extension Response {
    
    //数据转模型 映射
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: self.data, encoding: .utf8) // nsdata to string
//        DDLogVerbose(">>>reponse json string:\(jsonString ?? "")")
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}
