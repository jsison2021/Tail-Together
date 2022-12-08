//
//  SignOnViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/2/22.
//

import UIKit
import Parse
import AlamofireImage

class SignOnViewController: UIViewController {
    
    
    @IBOutlet weak var UsernameLoginField: UITextField!
  
    @IBOutlet weak var PasswordLoginField: UITextField!
    
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var emailLabelChanged: UILabel!
    
    
    @IBOutlet weak var passwordLabelChanged: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //resetForm()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func OnSignOnButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: UsernameLoginField.text!, password: PasswordLoginField.text!){
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "MainSegue", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Invalid Email or Password", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
               print("Error: \(String(describing: error?.localizedDescription)))")
            }
        }
    }
  
}
