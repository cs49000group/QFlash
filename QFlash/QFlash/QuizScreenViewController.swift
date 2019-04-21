//
//  QuizScreenViewController.swift
//  QFlash
//
//  Created by Max Cohen on 4/12/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class QuizScreenViewController: UIViewController {
    
    var quiz: PFObject! {
        didSet {
            quiz.fetchInBackground { (object, error) in
                self.setupView()
            }
        }
    }

    @IBOutlet weak var multipleChoiceHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var freeResponseHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var freeResponseTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var answer1: UILabel!
    
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var answer2: UILabel!
    
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var answer3: UILabel!
    
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var answer4: UILabel!
    
    var mcAnswer: String?
    var isShortAnswer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(quiz)
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        guard let quiz = quiz else { return }
        titleLabel.text = quiz["title"] as? String
        questionLabel.text = quiz["question"] as? String
        if (quiz["answer2"] as! String == "") {
            // Short answer
            isShortAnswer = true
            multipleChoiceHeightConstraint.constant = 0
            multipleChoiceHeightConstraint.isActive = true
        } else {
            freeResponseHeightConstraint.constant = 0
            freeResponseHeightConstraint.isActive = true
            answer1.text = quiz["answer1"] as? String
            answer2.text = quiz["answer2"] as? String
            answer3.text = quiz["answer3"] as? String
            answer4.text = quiz["answer4"] as? String
            setGray()

        }
    }

    @IBAction func answerSelected(_ sender: UIButton) {
        setGray()
        if sender == button1 {
            button1.setTitleColor(view.tintColor, for: .normal)
            mcAnswer = answer1.text ?? ""
        } else if sender == button2 {
            button2.setTitleColor(view.tintColor, for: .normal)
            mcAnswer = answer2.text ?? ""
        } else if sender == button3 {
            button3.setTitleColor(view.tintColor, for: .normal)
            mcAnswer = answer3.text ?? ""
        } else if sender == button4 {
            button4.setTitleColor(view.tintColor, for: .normal)
            mcAnswer = answer4.text ?? ""
        }
    }
    
    func setGray() {
        button1.setTitleColor(.gray, for: .normal)
        button2.setTitleColor(.gray, for: .normal)
        button3.setTitleColor(.gray, for: .normal)
        button4.setTitleColor(.gray, for: .normal)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let answer: String
        if isShortAnswer {
            guard let shortAnswer = freeResponseTextField.text else { return }
            answer = shortAnswer
        } else {
            guard let mcAnswer = mcAnswer else { return }
            answer = mcAnswer
        }
        
        // Trisha upload here:
        let stuAnswer = PFObject(className: "Answers")
        stuAnswer["class"] = quiz["class"]
        stuAnswer["title"] = titleLabel.text!
        stuAnswer["question"] = questionLabel.text!
        stuAnswer["student"] = PFUser.current()!
        stuAnswer["answer"] = answer as String
        quiz["answers"] = answer
    
        
        stuAnswer.saveInBackground { (sucess, error) in
            if (sucess) {
                print("saved!")
                //self.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print("error!")
            }
        }
    }
    
    
    @IBAction func onViewResults(_ sender: Any) {
        if PFUser.current() == quiz["author"] as? PFUser {
            self.performSegue(withIdentifier: "resultSegue", sender: nil)
            print("user is author of quiz")
            
        } else {
            print("user is not author of quiz")
        }
    }
}

