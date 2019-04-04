//
//  JoinClassViewController.swift
//  QFlash
//
//  Created by Ryan Sullivan on 4/4/19.
//  Copyright © 2019 QFlash. All rights reserved.
//

import UIKit

class JoinClassViewController: UIViewController {

    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classTextField.delegate = self
        joinButton.layer.cornerRadius = 4
        joinButton.clipsToBounds = true
        joinButton.backgroundColor = view.tintColor
        joinButton.setTitleColor(.white, for: .normal)
        joinButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        // Do any additional setup after loading the view.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func joinPressed(_ sender: Any) {
        // Join class
    }

}

extension JoinClassViewController: UIPopoverPresentationControllerDelegate {
    
}

extension JoinClassViewController: UITextFieldDelegate {
    
}
