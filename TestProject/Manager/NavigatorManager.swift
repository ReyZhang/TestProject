//
//  NavigatorManager.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import Foundation
import UIKit

class NavigatorManager {
    
    static var `default` = NavigatorManager()
    init() {}
    
    enum Scene: String {
        case result = "result"
        case history = "history"
    }
    
    func get(scene: Scene) -> UIViewController? {
        let vc:UIViewController?
        switch scene {
        case .result:
            vc = ResultViewController()
        case .history:
            vc = HistoryViewController()
        }
        return vc
    }
    
    
    func show(scene: Scene, sender: UIViewController?) {
        
        guard let target = get(scene: scene) else {
            fatalError("未获取到目标控制器")
        }
        
        guard let sender = sender else {
            fatalError("需要传入发送者")
        }
        
        
        if let nav = sender as? BaseNavigationController {
            nav.pushViewController(target, animated: true)
            return
        }
        
    }
    
}
