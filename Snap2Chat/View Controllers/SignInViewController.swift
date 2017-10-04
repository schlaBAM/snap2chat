//
//  ViewController.swift
//  Snap2Chat
//
//  Created by BAM on 2017-10-01.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTapped(_ sender: Any) {
        //auth, go to next VC
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
            print("Sign in: \(user)")
            if error != nil {
                print(error!)
                Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordText.text!, completion: { (user, error) in
                        if error != nil {
                            print(error!)
                        } else{
                            print("create user / signin success")
                            let users = Database.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
                            self.performSegue(withIdentifier: "signinSegue", sender: nil)
                    }
                })
            } else {
                print("sign in success")
//                Database.database().reference().child(self.emailText.text!).setValue(self.passwordText.text!)
                self.performSegue(withIdentifier: "signinSegue", sender: nil)

            }
        }
        
        
        
    }

}

