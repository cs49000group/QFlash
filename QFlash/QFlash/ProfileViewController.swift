//
//  ProfileViewController.swift
//  QFlash
//
//  Created by Ryan Sullivan on 3/25/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController {
    var classes: [PFObject] = []

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var classTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        nameLabel.text = PFUser.current()?.username
        classTableView.delegate = self
        classTableView.dataSource = self
        // Do any additional setup after loading the view.
                
        let query = PFQuery(className:"Class")
        query.limit = 100
        query.whereKey("author", equalTo: PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (newClasses, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                if let classes = newClasses {
                    self.classes.append(contentsOf: classes)
                    self.classTableView.reloadData()
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
    
    @IBAction func onLogoutButton(sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Class Code Cell") as? ClassCodeTableViewCell {
            cell.cellClass = classes[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}
