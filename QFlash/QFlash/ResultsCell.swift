//
//  ResultsCell.swift
//  QFlash
//
//  Created by Trisha Ghosh  on 4/21/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class ResultsCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var answerName: UILabel!
    
    var cellResult: PFObject? {
        didSet{
            cellResult?.fetchIfNeededInBackground(block: { (updatedAnswer, error) in
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell() {
        guard let cellResult = cellResult else { return }
        studentName.text = cellResult["student"] as? String
        answerName.text = cellResult["answer"] as? String
    }

}
