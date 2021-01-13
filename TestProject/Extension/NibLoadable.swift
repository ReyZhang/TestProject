//
//  NibLoadable.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//  定义通过Nib加载view的协议

import Foundation
import UIKit


protocol NibLoadable {
    
}


extension NibLoadable where Self : UIView {
    
    static func nib(_ name:String? = nil) -> UINib {
        let name = name.map { $0 } ?? identifier
        return UINib(nibName: name, bundle: nil)
    }
    
    static var identifier : String {
        return "\(self)"
    }
    
    static func loadFromNib(_ nibName: String? ) -> Self {
        let nib = self.nib(nibName)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }

}

//所有直接或间接继承自UIView的对象，都实现此协议
extension UIView : NibLoadable {}


