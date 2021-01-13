//
//  ViewController.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/12.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    fileprivate lazy var tableView:UITableView = {
        let tb: UITableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "\(UITableViewCell.self)")
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    lazy var titles:[String] = ["解析返回结果","调用历史"]
    lazy var scenes:[NavigatorManager.Scene] = [.result, .history]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Function List"
        
        initView()
    }

    
    func initView() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        let title = self.titles[indexPath.row]
        
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Configs.Const.cellDefaultHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scene = self.scenes[indexPath.row]
        NavigatorManager.default.show(scene: scene, sender: self.navigationController)
    }
}
