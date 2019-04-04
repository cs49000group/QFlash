//
//  CreateClassViewController.swift
//  QFlash
//
//  Created by Ryan Sullivan on 3/25/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class CreateClassViewController: UIViewController {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    
    var shouldDismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func createNewClass(named name: String) {
        guard let user = PFUser.current() else { return }
        
        let newClass = PFObject(className: "Class")
        newClass["name"] = name
        newClass["author"] = user
        
        let hashString = "\(abs(Date().hashValue))"
        let hash = String(hashString.prefix(7))
        newClass["hash"] = hash
        
        //user.add(newClass, forKey: "classes")
        
        newClass.saveInBackground { (success, error) in
            if success {
                print("saved")
                let alertController = UIAlertController(title: "Class Created Successfully!",
                                              message: "Your class code is \(hash)",
                                              preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                    if action.style == .cancel {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }))

                self.present(alertController, animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
        
        user.saveInBackground { (success, error) in
            if success {
                print("saved")
                if self.shouldDismiss {
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.shouldDismiss = true
                }
            } else {
                print("error")
            }
        }
    }
    
    @IBAction func createPressed(_ sender: Any) {
        if let text = nameField.text {
            createNewClass(named: text)
        }
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
