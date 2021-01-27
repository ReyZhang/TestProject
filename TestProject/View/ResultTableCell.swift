//
//  ResultTableCell.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import UIKit

class ResultTableCell: UITableViewCell {

    @IBOutlet weak var apiNameLabel: UILabel!
    
    @IBOutlet weak var apiUrlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func bindData(_ data: [String:Any]) {
        self.apiNameLabel.text = data["key"] as? String
        self.apiUrlLabel.text = data["value"] as? String
    }
    
}
