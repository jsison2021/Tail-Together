//
//  SignUpViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/2/22.
//

import UIKit
import Parse
import AlamofireImage

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var EmailField: UITextField!
   
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var UserNameField: UITextField!
    
    @IBOutlet weak var GoTotheLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnSignUpButton(_ sender: Any) {
        
        let user = PFUser()
        user["FirstName"] = FirstName.text
        user["LastName"] = LastName.text
        user.email = EmailField.text
        user.username = UserNameField.text
        user.password = PasswordField.text
        
        
        user.signUpInBackground {(success, error) in
            if success{
                self.performSegue(withIdentifier: "GoTotheLoginScreen", sender: nil)
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
