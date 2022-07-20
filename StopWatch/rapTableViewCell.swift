//
//  TableViewCell.swift
//  StopWatch
//
//  Created by 武樋一樹 on 2022/07/20.
//

import UIKit

class rapTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
