//
//  ViewController.swift
//  flashChat
//
//  Created by Maruf's Macbook Pro on 23/10/23.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = K.appName
    }
    



}

