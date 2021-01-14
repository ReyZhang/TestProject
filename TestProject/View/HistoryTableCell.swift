//
//  HistoryTableCell.swift
//  TestProject
//
//  Created by rey zhang on 2021/1/13.
//

import UIKit

class HistoryTableCell: UITableViewCell {

    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModel(_ model: HistoryRecord) {
        self.nameLabel.text = model.apiName
        let formater = DateFormatter()
        formater.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        self.dateLabel.text = formater.string(from: model.createTime!)
        
    }
    
}
