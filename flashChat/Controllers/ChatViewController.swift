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
    
    var messages : [Message] = [
    Message(sender: "maruf@gmail.com", body: "Hey!"),
    Message(sender: "a@b.com", body: "Hello!"),
    Message(sender: "maruf@gmail.com", body: "What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up! What's up!"),]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = K.appName
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
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


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.label.text = messages[indexPath.row].body
        
        return cell
    }
    
    
}


