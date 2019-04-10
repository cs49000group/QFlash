//
//  JoinClassTableViewCell.swift
//  
//
//  Created by Ryan Sullivan on 4/4/19.
//

import UIKit

class JoinClassTableViewCell: UITableViewCell {

    @IBOutlet weak var joinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        joinLabel.textColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
