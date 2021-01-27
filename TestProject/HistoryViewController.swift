//
//  HistoryViewController.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import Foundation
import UIKit
import MJRefresh

class HistoryViewController : BaseViewController {
    
    
    fileprivate lazy var tableView:UITableView = {
        let tb: UITableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        tb.register(HistoryTableCell.nib(), forCellReuseIdentifier: HistoryTableCell.identifier)
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        tb.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))
        return tb
    }()
    
    
    private var pageIndex  = 0
    
    var array:[HistoryRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "调用历史"
        
        initView()
        loadData()
    }
    
    
    
    func initView() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
    func loadData() {
        let manager = CoreDataManager.default
        if let dataArray = manager.query(HistoryRecord.self, nil, self.pageIndex, 30) {
            if pageIndex > 0 {
                self.array.append(contentsOf: dataArray)
            }else {
                self.array = dataArray
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    @objc func loadMore() {
        self.pageIndex += 1
        loadData()
    }
}


extension HistoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableCell.identifier, for: indexPath) as! HistoryTableCell
        
        let model = array[indexPath.row] as HistoryRecord
        
        cell.bindModel(model)
        cell.selectionStyle = .none
        return cell
    }
}


extension HistoryViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Configs.Const.cellDefaultHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = array[indexPath.row] as HistoryRecord
        
        NavigatorManager.default.show(scene: .result(model: model), sender: self.navigationController)
    }
}
