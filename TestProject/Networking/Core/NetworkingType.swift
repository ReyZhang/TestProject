//
//  NetworkingType.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//  当实现 Moya TargetType协议的类不止一个时（分模块创建Api接口）
//  设计一个协议， 将MoyaProvider泛型类的类型延迟到具体类来指定类型

import Foundation
import Moya
import RxSwift
import HandyJSON


protocol NetworkingType {
    associatedtype T: TargetType
    
    var provider:MoyaProvider<T> { get }
    
    static func defaultNetworking() -> Self
}


/*!
 有关插件扩展
 */
extension NetworkingType {
    
    
    // 扩展中只支持计算属性
    static var plugins:[PluginType] {
        var plugins : [PluginType] = []
        
        if Configs.Network.logEnabled {
            plugins.append(NetworkLoggerPlugin())
        }
        
        return plugins
    }
}


/*!
 有关请求扩展
 */
extension NetworkingType {
    
    // 将请求结果转成json对象
    func request(_ token:T) -> Observable<Any> {
        return self.provider.rx.request(token)
            .mapJSON()
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
    
    // 将请求结果直接转成模型
    func requestModel<H:HandyJSON>(_ token: T, _ model:H.Type) -> Observable<H> {
        return self.provider.rx.request(token)
            .asObservable()
            .mapModel(H.self)
            .observeOn(MainScheduler.instance)
    }
    
}
