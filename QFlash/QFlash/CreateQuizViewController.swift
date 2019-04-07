//
//  CreateQuizViewController.swift
//  QFlash
//
//  Created by Max Cohen on 4/6/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class CreateQuizViewController: UIViewController {

    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var oneField: UITextField!
    @IBOutlet weak var twoField: UITextField!
    @IBOutlet weak var threeField: UITextField!
    @IBOutlet weak var fourField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createQuiz(_ sender: Any) {
        guard let user = PFUser.current() else { return }
        
        let newQuiz = PFObject(className: "Quiz")
        newQuiz["question"] = questionField.text
        newQuiz["answer1"] = oneField.text
        newQuiz["answer2"] = twoField.text
        newQuiz["answer3"] = threeField.text
        newQuiz["answer4"] = fourField.text
        newQuiz["author"] = user
        
        //user.add(newClass, forKey: "classes")
        
        newQuiz.saveInBackground { (success, error) in
            if(success){
                print("success")
                //self.navigationController?.popToRootViewController(animated: true)
            }
            else{
                print("Error")
            }
        }
        
        user.saveInBackground { (success, error) in
            if success {
                print("saved")
                self.navigationController?.popToRootViewController(animated: true)
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
