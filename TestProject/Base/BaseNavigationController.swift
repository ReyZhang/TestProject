//
//  BaseNavigationController.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BaseNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let array:[UIViewController] = self.children;
        if array.count > 0 {
            print("can be back")
            
        }
        super.pushViewController(viewController, animated: animated)
    }
}
