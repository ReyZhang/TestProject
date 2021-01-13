//
//  BaseViewController.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = [];
    }

    //释放
    deinit {
        logDebug("\(String(describing: self)) 被释放")
    }
}
