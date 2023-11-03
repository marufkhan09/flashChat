//
//  ChatViewController.swift
//  flashChat
//
//  Created by Maruf's Macbook Pro on 30/10/23.
//

import UIKit
import FirebaseAuth
import Toast

class ChatViewController: UIViewController {
    let firebaseAuth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "⚡️FlashChat"

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let e {
            self.view.makeToast("Error signing out: %@" + e.localizedDescription)
            
            
        }
    }
}
