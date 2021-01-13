//
//  ResultViewController.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import Foundation
import UIKit

class ResultViewController: BaseViewController {
    
    
    fileprivate lazy var tableView:UITableView = {
        let tb: UITableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        tb.register(ResultTableCell.nib(), forCellReuseIdentifier: ResultTableCell.identifier)
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    
    private lazy var array:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "请求结果"
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
        let defaults = UserDefaults.standard
        array = defaults.array(forKey: Configs.UserDefaultKey.getLatestDataKey) ?? []
        self.tableView.reloadData()
    }
}

extension ResultViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableCell.identifier, for: indexPath) as! ResultTableCell
        let dic = array[indexPath.row]
        cell.bindData(dic as! [String : Any])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
}

extension ResultViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
