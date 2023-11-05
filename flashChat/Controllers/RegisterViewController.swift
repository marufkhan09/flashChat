//
//  RegisterViewController.swift
//  flashChat
//
//  Created by Maruf's Macbook Pro on 23/10/23.
//

import UIKit
import FirebaseAuth
import Toast
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: CustomTextField!
    @IBOutlet weak var passwordTextfield: CustomTextField!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email  = emailTextfield.text
            , let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authresult, error in
                if let e = error {
                    
                    self.view.makeToast(e.localizedDescription)
                } else {
                    //Navigate to chatViewController
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
    }
}
