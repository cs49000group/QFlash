//
//  ClassCell.swift
//  QFlash
//
//  Created by Trisha Ghosh  on 4/7/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class ClassCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var cellClass: PFObject? {
        didSet{
            setupCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell() {
        guard let cellClass = cellClass else { return }
        nameLabel.text = cellClass["name"] as! String
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
