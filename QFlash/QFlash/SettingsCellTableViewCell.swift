//
//  SettingsCellTableViewCell.swift
//  QFlash
//
//  Created by Max Cohen on 4/20/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class SettingsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    
    var cellSetting: PFObject? {
        didSet{
            cellSetting?.fetchIfNeededInBackground(block: { (updatedSetting, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    self.setupCell()
                }
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell() {
        guard let cellSetting = cellSetting else { return }
        classLabel.text = cellSetting["name"] as! String
        hashLabel.text = cellSetting["hash"] as! String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
