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
    
    var quizClass: PFObject?

    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var oneField: UITextField!
    @IBOutlet weak var twoField: UITextField!
    @IBOutlet weak var threeField: UITextField!
    @IBOutlet weak var fourField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createQuiz(_ sender: Any) {
        guard let user = PFUser.current() else { return }
        
        let newQuiz = PFObject(className: "Quiz")
        newQuiz["question"] = questionField.text
        newQuiz["title"] = titleField.text
        newQuiz["answer1"] = oneField.text
        newQuiz["answer2"] = twoField.text
        newQuiz["answer3"] = threeField.text
        newQuiz["answer4"] = fourField.text
        newQuiz["author"] = user
        
        var quiz:Quiz = Quiz(title: titleField.text!, question: questionField.text!, answer1: oneField.text!, answer2: twoField.text!, answer3: threeField.text!, answer4: fourField.text!)
        
        //user.add(newClass, forKey: "classes")
        
        newQuiz.saveInBackground { (success, error) in
            if(success){
                print("success")
                self.dismiss(animated: true, completion: nil)
                //self.navigationController?.popToRootViewController(animated: true)
            }
            else{
                print("Error")
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

public class Quiz{
    var title: String
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    init(title: String, question: String, answer1: String, answer2: String, answer3: String, answer4: String){
        self.title = title
        self.question = question
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
    }
}
