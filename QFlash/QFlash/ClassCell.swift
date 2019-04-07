//
//  ClassCell.swift
//  QFlash
//
//  Created by Trisha Ghosh  on 4/7/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit

class ClassCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
