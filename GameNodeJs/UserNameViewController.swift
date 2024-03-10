//
//  UserNameViewController.swift
//  GameNodeJs
//
//  Created by Ehab on 09/03/2024.
//

import UIKit

class UserNameViewController: UIViewController {
    
    var username: String?
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapProceed(_ sender: Any) {
        if usernameTextField.text!.isEmpty {
            return
        }
        
        username = usernameTextField.text
        performSegue(withIdentifier: "GoToGame", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameViewController = segue.destination as! GameViewController
        gameViewController.username = username
    }
    
}
