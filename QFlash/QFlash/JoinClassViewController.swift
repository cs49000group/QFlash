//
//  JoinClassViewController.swift
//  QFlash
//
//  Created by Ryan Sullivan on 4/4/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

protocol JoinClassViewControllerDelegate {
    func didJoinClass(_ newClass: PFObject)
}

class JoinClassViewController: UIViewController {

    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    var delegate: JoinClassViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classTextField.delegate = self
        joinButton.layer.cornerRadius = 4
        joinButton.clipsToBounds = true
        joinButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func joinPressed(_ sender: Any) {
        // Join class
        guard let text = classTextField.text else { return }
            
        let query = PFQuery(className: "Class")
        query.whereKey("hash", equalTo: text)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "Could not join class",
                                                        message: "Your class code may be invalid. Check it and try again.",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else {
                if let joinedClass = objects?.first {
                    self.addCurrentUserToClass(joinedClass)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func addCurrentUserToClass(_ joinedClass: PFObject) {
        guard let user = PFUser.current() else { return }

        user.addUniqueObject(joinedClass, forKey: "classes")
        user.saveInBackground(block: { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
        
        joinedClass.addUniqueObject(user, forKey: "students")
        joinedClass.saveInBackground(block: { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                if let delegate = self.delegate {
                    delegate.didJoinClass(joinedClass)
                }
            }
        })
    }

}

extension JoinClassViewController: UIPopoverPresentationControllerDelegate {
    
}

extension JoinClassViewController: UITextFieldDelegate {
    
}
