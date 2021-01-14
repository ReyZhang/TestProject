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
import CoreData


var increament = 0  {
    didSet {
        let defaults = UserDefaults.standard
        defaults.setValue("\(oldValue)", forKey: Configs.UserDefaultKey.increamentKey)
    }
}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    
    
    lazy var persistentContainer: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: Configs.Const.dataModelName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    
    private var count = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
//        delAll()
//        readData()
        
        let defaults = UserDefaults.standard
        increament = defaults.integer(forKey: Configs.UserDefaultKey.increamentKey)
        
        
        taskOne()  //
        initLibs()
        showRootVC()
        return true
    }

}//end class


extension AppDelegate {
    
    private func showRootVC() {
        let vc = MainViewController()
        self.window?.rootViewController = BaseNavigationController(rootViewController: vc)
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
            .mapArray()
            .subscribe(onNext: { [self]
                (result) in
                self.count += 1
                
                //持久化存储返回结果
                let defaults = UserDefaults.standard
                defaults.setValue(result, forKey: Configs.UserDefaultKey.getLatestDataKey)
                
                //存储API调用记录
                storeCallRecored(result)
                
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
    
    
    func storeCallRecored(_ result:[Any]) {
        let manager = CoreDataManager.default
        let history = manager.getEntity(HistoryRecord.self)
        //对象赋值
        increament += 1
        history.id = Int32(increament)
        history.apiName = Configs.Network.githubBaseUrl
        history.result = result.getJsonString()
        history.createTime = Date()
        
        manager.insert()
        
    }
    
    
//    func delAll() {
//        let manager = CoreDataManager.default
//        manager.deleteAll(HistoryRecord.self)
//    }
    
//    func readData() {
//        let manager = CoreDataManager.default
//        if let array = manager.query(HistoryRecord.self) {
//            for info in array {
//                print("\(info.result)")
//            }
//        }else {
//            print("aa")
//        }
//
//    }
    
    
}




