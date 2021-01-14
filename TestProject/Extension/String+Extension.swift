//
//  String+Extension.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/14.
//

import Foundation

extension String {
    
    func getArrayFromJsonString() -> [Any]? {
        
        let jsonData:Data = self.data(using: .utf8)!
        
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        
        return array as? [Any]
    }
}
