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
    var quizClass: PFObject? {
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
                    self.quizzes.append(contentsOf: quizzes)
                    self.QuizTableView.reloadData()
                }
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
    }


