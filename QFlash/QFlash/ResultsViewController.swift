//
//  ResultsViewController.swift
//  QFlash
//
//  Created by Trisha Ghosh  on 4/21/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultsTableView: UITableView!
    var quiz: PFObject!
    var answers: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        
        //ResultTableView.delegate = self
        // QuizTableView.dataSource = self
        
        // Load answers here
        let query = PFQuery(className:"Answers")
        query.limit = 100
        query.whereKey("title", equalTo: quiz["title"])
        query.whereKey("class", equalTo: quiz["class"])
        query.includeKey("answer")
        query.includeKey("student")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (newAnswers, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                if let answers = newAnswers {
                    self.answers.append(contentsOf: answers)
                    self.resultsTableView.reloadData()
            
                print(" answers loaded")
                }
                
            }
        }
    }

    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "resultSegue" {
//            if let destination = segue.destination as? QuizScreenViewController,
//                let indexPath = resultsTableView.indexPathForSelectedRow,
//                let cell = resultsTableView.cellForRow(at: indexPath) as? ResultsCell {
//                print("sent ResultCell")
//                destination.quiz = cell.cellResult
//            }
//        }
//
//    }
}

    extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return answers.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell")
                as! ResultsCell
            
           let answerName = answers[indexPath.row - 1]
            cell.cellResult = answerName
                
                return cell
            
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
