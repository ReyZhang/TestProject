//
//  CoreDataManager.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/14.
//  CoreData 封装， CRUD(增删改查)

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let `default` = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: Configs.Const.dataModelName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
 
    var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    init() {
    }
    
    
    // MARK: - 获取Entity
    func getEntity<T: NSManagedObject>(_ type:T.Type) -> T {
       return NSEntityDescription.insertNewObject(forEntityName: "\(type)",
                                                          into: context) as! T
    }
    
    // MARK: - 插入操作
    @discardableResult
    func insert() -> Bool {
        var flag = true
        //保存
        do {
            try context.save()
            print("保存成功！")
            flag = true
        } catch {
            flag = false
            fatalError("不能保存：\(error)")
        }
        return flag
    }
    
    
    // MARK: - 查询
    func query<T:NSManagedObject>(_ type:T.Type, _ predicate:NSPredicate? = nil, _ pageIndex:Int = 0, _ pageSize : Int?  = 10) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName:"\(type)")
        
        //sort
        let sort = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        //num
        if let pageSize = pageSize {
            fetchRequest.fetchLimit = pageSize //限定查询结果的数量
            fetchRequest.fetchOffset = pageIndex * pageSize //查询的偏移量
        }
        
        // filter
        if let predicate = predicate {
            fetchRequest.predicate  = predicate
        }
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            return fetchedObjects
        }
        catch {
            return nil
        }
    }
    
    
    //MARK: - 删除
    @discardableResult
    func delete<T:NSManagedObject>(_ type:T.Type, _ identifier:String = "id", _ value:Int) -> Bool {
        let predicate = NSPredicate(format: "\(identifier) = \(value)", "")
    
        if let fetchedObjects =  query(type, predicate) {
            for info in fetchedObjects {
                context.delete(info)
            }
            //重新保存-更新到数据库
            try! context.save()
            return true
        }else {
            return false
        }
        
    }
    
    
    @discardableResult
    func deleteAll<T:NSManagedObject>(_ type:T.Type) -> Bool {
        if let fetchedObjects = query(type) {
            for info in fetchedObjects {
                context.delete(info)
            }
            //重新保存-更新到数据库
            try! context.save()
            return true
        }else {
            return false
        }
    }
    
}
