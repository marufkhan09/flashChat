//
//  ChatViewController.swift
//  flashChat
//
//  Created by Maruf's Macbook Pro on 30/10/23.
//

import UIKit
import FirebaseAuth
import Toast
import FirebaseFirestore

class ChatViewController: UIViewController {
    let firebaseAuth = Auth.auth()
   // let messageService = MessageServices()
    let db = Firestore.firestore()
    
    @IBOutlet weak var messageTextField: UITextField!
    var messages : [Message] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = K.appName
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
       
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            if let e = error {
                self.view.makeToast(e.localizedDescription)
            }else {
                self.messages = []
                if let snapshotDocuments =  querySnapshot?.documents {
                    snapshotDocuments.forEach { doc in
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String{
                            self.messages.append(Message(sender: sender, body: body))
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                       
                    }
                }
            }
        }
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let e {
            self.view.makeToast("Error signing out: %@" + e.localizedDescription)
            
            
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender,K.FStore.bodyField:messageBody,K.FStore.dateField:Date().timeIntervalSince1970]) { error in
                if let e = error {
                    self.view.makeToast(e.localizedDescription)
                }else {
                    print("Success")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
        
        
    }
    
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
     
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
        }else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
        }
        
        return cell
    }
    
    
}


