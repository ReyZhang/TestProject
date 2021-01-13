//
//  AppDelegate.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//

import UIKit
import RxSwift
import NSObject_Rx

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var shared:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        // 启动5秒后，调用一次， 只后每隔5秒调用一次
        Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
            .delay(.seconds(5), scheduler: MainScheduler.instance)
            .flatMap { (second) -> Observable<Any> in
                return Api.default.apiSummery()
            }
            .subscribe(onNext: {
                (result) in
                print(result)
            }).disposed(by: rx.disposeBag)
        
    
        
        
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }




}

