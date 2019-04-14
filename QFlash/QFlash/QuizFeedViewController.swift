//
//  QuizFeedViewController.swift
//  QFlash
//
//  Created by Max Cohen on 3/27/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class QuizFeedViewController: UIViewController {
    
    @IBOutlet weak var QuizTableView: UITableView!
    var quizClass:  PFObject! {
        didSet {
            // update using class information
        }
    }
    var quizzes: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        QuizTableView.delegate = self
        QuizTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        quizzes.removeAll()
        
        let query = PFQuery(className: "Quiz")
        query.includeKey("title")
        query.limit = 100
        query.findObjectsInBackground { (newQuizzes, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else{
                if let  quizzes = newQuizzes {
                    for quiz in quizzes{
                        if(quiz.object(forKey: "class") != nil){
                            var s1: String
                            var s2: String
                            s1 = quiz.object(forKey: "class") as! String
                            s2 = self.quizClass.object(forKey: "name") as! String
                            if(s1 == s2){
                                self.quizzes.append(quiz)
                                self.QuizTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "CreateQuiz Segue" {
            let destination = segue.destination as? CreateQuizViewController
            destination!.quizClass = self.quizClass
        }
        
        if segue.identifier == "QuizScreen Segue" {
            if let destination = segue.destination as? QuizScreenViewController,
                let indexPath = QuizTableView.indexPathForSelectedRow,
                let cell = QuizTableView.cellForRow(at: indexPath) as? QuizCell {
                print("sent2")
                destination.quiz = cell.cellQuiz
            }
        }

    }
    
}
    extension QuizFeedViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return quizzes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if (indexPath.row <= quizzes.count) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell") as! QuizCell
                
                let quizName = quizzes[indexPath.row]
                cell.cellQuiz = quizName
                
                return cell
                
            }
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "QuizScreen Segue", sender: nil)
        }
    }


