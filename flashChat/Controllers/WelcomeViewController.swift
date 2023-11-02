//
//  ViewController.swift
//  flashChat
//
//  Created by Maruf's Macbook Pro on 23/10/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleAnimation(title: "⚡️FlashChat")
    }
    
    func titleAnimation(title:String){
        var charIndex = 0.0
        print(charIndex)
       
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(String(letter))
            }
            charIndex += 1
        }
    }


}

