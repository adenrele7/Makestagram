//
//  LoginViewController.swift
//  Makestagram
//
//  Created by isiah womack on 7/10/17.
//  Copyright © 2017 Adenrele Adepoju. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

import FirebaseAuth
import FirebaseAuthUI
typealias FIRUser = FirebaseAuth.User

class  LoginViewController: UIViewController{
   
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - IBActions
    
        
    
}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        // 1
        guard let user = user
            else { return }
        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)

        
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                print("Welcome back, \(user.username).")
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
        
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let _ = User(snapshot: snapshot) {
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
    }
}

