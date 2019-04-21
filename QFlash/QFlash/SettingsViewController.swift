//
//  SettingsViewController.swift
//  QFlash
//
//  Created by Ryan Sullivan on 3/25/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    var classes: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        classes.removeAll()
        
        let query = PFQuery(className: "Class")
        query.includeKeys(["name", "hash"])
        query.limit = 100
        query.findObjectsInBackground { (newSettings, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else{
                if let  classes = newSettings {
                    self.classes.append(contentsOf: classes)
                    self.settingTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = loginViewController
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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row <= classes.count) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingsCellTableViewCell
            
            let className = classes[indexPath.row]
            cell.cellSetting = className
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    
/*    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "QuizScreen Segue", sender: nil)
    }
}*/

}
