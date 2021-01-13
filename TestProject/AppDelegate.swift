//
//  AppDelegate.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//

import UIKit
import RxSwift
import NSObject_Rx
import CocoaLumberjack

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    private var count = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        taskOne()  //
        initLibs()
        showRootVC()
        return true
    }

}//end class


extension AppDelegate {
    
    private func showRootVC() {
        let vc = MainViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()
    }
    
    // MARK : - 功能1：应用启动5秒后，调用一次， 之后每隔5秒调用一次
    public func taskOne() {
        print("进入时间：\(Date())")
        Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
//            .delay(.seconds(5), scheduler: MainScheduler.instance)
            .flatMap { (second) -> Observable<Any> in
                let message = self.count == 0 ? "首次执行时间：" : "第\(self.count)次间隔执行："
                logDebug(message + "\(Date())")
                return Api.default.apiSummery()
            }
            .subscribe(onNext: {
                (result) in
                self.count += 1
                
                print(result)
            }).disposed(by: rx.disposeBag)
    }
    
    func initLibs() {
        setupCocoaLumberjack()
    }
    
    
    //配置日志
    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    
}




