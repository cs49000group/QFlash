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
            cellClass?.fetchIfNeededInBackground(block: { (updatedClass, error) in
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
        guard let cellClass = cellClass else { return }
        nameLabel.text = cellClass["name"] as! String
        if let author = cellClass["author"] as? PFUser {
            author.fetchIfNeededInBackground { (object, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let user = object as? PFUser {
                        self.authorLabel.text = user.username as! String
                    }
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
