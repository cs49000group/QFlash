//
//  QuizCell.swift
//  QFlash
//
//  Created by Max Cohen on 4/7/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class QuizCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var cellQuiz: PFObject? {
        didSet{
            cellQuiz?.fetchIfNeededInBackground(block: { (updatedQuiz, error) in
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
        guard let cellQuiz = cellQuiz else { return }
        titleLabel.text = cellQuiz["title"] as! String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
