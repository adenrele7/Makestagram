//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Make School on 7/14/17.
//  Copyright © 2017 Adenrele Adepoju. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
   
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = userNameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            print("Created new user: \(user.username)")
        }
        UserService.create(firUser, username: username) { (user) in
            guard let _ = user else {
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}

