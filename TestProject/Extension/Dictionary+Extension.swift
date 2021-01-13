//
//  Dictionary+Extension.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//  字典转数组

import Foundation
import RxSwift

extension ObservableType where Element == Any {
    
    // 字典转数组
    func mapArray() -> Observable<[Any]> {
        return flatMap { (response) -> Observable<[Any]> in
            if response is Array<Any> {
                return Observable.just(response as? Array<Any> ?? [])
            }
            if let dic = response as? Dictionary<String,Any> {
                return Observable.just(dic.mapArray())
            }
            return Observable.just([])
        }
    }
}

extension Dictionary   {
    
    func mapArray() -> [Any] {
        var array:[Any] = []
        
        for (key,val) in self {
            var dic : [String:Any] = [:]
            dic["key"] = key
            dic["value"] = val
            array.append(dic)
        }
        return array
    }
    
}
