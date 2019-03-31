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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func createNewClass(named name: String) {
        guard let user = PFUser.current() else { return }
        
        let newClass = PFObject(className: "Class")
        newClass["name"] = name
        newClass["author"] = user
        user.add(newClass, forKey: "classes")
        
        newClass.saveInBackground { (success, error) in
            if success {
                print("saved")
            } else {
                print("error")
            }
        }
        
        user.saveInBackground { (success, error) in
            if success {
                print("saved")
            } else {
                print("error")
            }
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
