//
//  ClassCodeTableViewCell.swift
//  QFlash
//
//  Created by Ryan Sullivan on 4/20/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class ClassCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    var cellClass: PFObject? {
        didSet {
            loadClass()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadClass() {
        classLabel.text = cellClass?["name"] as? String ?? ""
        codeLabel.text = cellClass?["hash"] as? String ?? ""
    }
    
}
