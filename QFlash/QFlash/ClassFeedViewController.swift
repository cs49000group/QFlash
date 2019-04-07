//
//  ClassFeedViewController.swift
//  QFlash
//
//  Created by Ryan Sullivan on 3/25/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class ClassFeedViewController: UIViewController {

    @IBOutlet weak var classTableView: UITableView!
    
    var classes: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        classTableView.delegate = self
        classTableView.dataSource = self
        
        // Load classes here
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ClassFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Join Cell") as? JoinClassTableViewCell {
                return cell
            }
        } else if (indexPath.row <= classes.count) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell") as! ClassCell
            
            let className = classes[indexPath.row - 1]
            cell.cellClass = className
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let joinClassController = storyboard.instantiateViewController(withIdentifier: "Join Popover")
            if let joinController = joinClassController as? JoinClassViewController {
                joinController.delegate = self
            }
            
            joinClassController.modalPresentationStyle = .popover
            joinClassController.preferredContentSize = CGSize(width: 300, height: 100)
            
            if let popoverController = joinClassController.popoverPresentationController,
                let joinClassPopover = joinClassController as? UIPopoverPresentationControllerDelegate {
                popoverController.delegate = joinClassPopover
                popoverController.backgroundColor = .white
                
                if let joinCell = tableView.cellForRow(at: indexPath) as? JoinClassTableViewCell {
                    popoverController.sourceView =  joinCell.joinLabel
                    let frame = joinCell.joinLabel.frame
                    popoverController.sourceRect = CGRect(x: (frame.width / 2), y: frame.height, width: 1, height: 1)
                }

                popoverController.permittedArrowDirections = .up
                present(joinClassController, animated: true, completion: nil)
            }
        } else {
            // Add code for selecting a class here
            
        }
    }
}

extension ClassFeedViewController: JoinClassViewControllerDelegate {
    func didJoinClasss(_ newClass: PFObject) {
        classes.append(newClass)
        classTableView.reloadData()
    }
}
