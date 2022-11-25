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

        resetForm()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func resetForm(){
        
        /* Variables*/
        SignInButton.isEnabled = false
        emailLabelChanged.isHidden = false
        passwordLabelChanged.isHidden = false
        
        emailLabelChanged.text = ""
        passwordLabelChanged.text = ""
        
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
    
    
    @IBAction func OnSignOnButton(_ sender: Any) {
        resetForm()
}
    
    
    
    @IBAction func emailChanged(_ sender: Any) {
        if let errorMessage = invalidEmail(UsernameLoginField.text!)
        {
            emailLabelChanged.text = errorMessage
            emailLabelChanged.isHidden = false
        }
        else
        {
            emailLabelChanged.isHidden = true
        }
        checkForValidForm()
    }
    
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let errorMessage = invalidPassword(PasswordLoginField.text!)
        {
            passwordLabelChanged.text = errorMessage
            passwordLabelChanged.isHidden = false
        }
        else
        {
            passwordLabelChanged.isHidden = true
        }
        checkForValidForm()
    }
    
    func invalidEmail(_ value: String) -> String? {
        let emailvalidation =  "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailvalidation)
        if !predicate.evaluate(with: value){
            return "Invalid Email Address"
        }
        return nil
    }
    
    func checkForValidForm(){
        if emailLabelChanged.isHidden{
            SignInButton.isEnabled = true
        }
        else
        {
            SignInButton.isEnabled = false
        }
    }
    
    //STILL NEED TO WORK ON TO FIX THE PASSWORD LABEL
    func invalidPassword(_ value: String) -> String? {
        if value.count < 7 {
           return "Password must be at least 7 characters"
        }
        if containsDigit(value){
            return "Password must contain at least 1 digit"
        }
        if containsLowerCase(value){
           return "Password must contain at least 1 lower case"
        }
        if containsUpperCase(value){
           return "Password must contain at least 1 upper case"
        }
        return nil
    }
    
    func containsDigit(_ value: String) -> Bool {
        
        let digits = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", digits)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool {
        
        let lowerCase = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", lowerCase)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool {
        
        let upperCase = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", upperCase)
        return !predicate.evaluate(with: value)
    }
    

}
