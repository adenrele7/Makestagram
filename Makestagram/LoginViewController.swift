//
//  LoginViewController.swift
//  Makestagram
//
//  Created by isiah womack on 7/10/17.
//  Copyright © 2017 Adenrele Adepoju. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI

class  LoginViewController: UIViewController{
   
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        print("login button tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - IBActions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }

}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        print("handle user signup / login")
    }
}
