//
//  Array+Extension.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/14.
//

import Foundation

extension Array {
    
    func getJsonString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        let JSONString = String(data: data!, encoding: String.Encoding.utf8)
        return JSONString
    }
}
