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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func OnSignOnButton(_ sender: Any) {
    
    let username = UsernameLoginField.text!
    let password = PasswordLoginField.text!
    
       
    
    PFUser.logInWithUsername(inBackground: username, password: password){
        (user, error) in
        if user != nil {
            self.performSegue(withIdentifier: "MainSegue", sender: nil)
            
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
