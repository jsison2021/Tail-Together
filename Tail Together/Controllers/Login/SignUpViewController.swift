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
    
    let user = PFUser()
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var EmailField: UITextField!
   
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var UserNameField: UITextField!
    
    @IBOutlet weak var FnameError: UILabel!
    @IBOutlet weak var LnameError: UILabel!
    @IBOutlet weak var emaiError: UILabel!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var GoTotheLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        resetForm()
        // Do any additional setup after loading the view.
    }
    
    func resetForm(){
        
        SignUpButton.isEnabled = false
        FnameError.isHidden = false
        LnameError.isHidden = false
        emaiError.isHidden = false
        usernameError.isHidden = false
        passwordError.isHidden = false
        
        
        FnameError.text = ""
        LnameError.text = ""
        emaiError.text = " "
        usernameError.text = ""
        passwordError.text = ""
        
        
        
        //user["LastName"] = LastName.text
        //user.email = EmailField.text
       // user.username = UserNameField.text
       // user.password = PasswordField.text
        
        
        user.signUpInBackground {(success, error) in
            if success{
                self.performSegue(withIdentifier: "GoTotheLoginScreen", sender: nil)
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))")
            }
        }
        
        
    }
    
    
    @IBAction func FnameChanged(_ sender: Any) {
       // var Fname = user["FirstName"]
        //if Fname = FirstName.text{
            
        user["FirstName"] = FirstName.text
       
            
    }
    
    
    @IBAction func LnameChanged(_ sender: Any) {
        user["LastName"] = LastName.text
    }
    
    
    @IBAction func emailChanged(_ sender: Any) {
        
        if let errorMessage = invalidEmail(EmailField.text!)
          
        {
            emaiError.text = errorMessage
            emaiError.isHidden = false
        }
        else
        {
            emaiError.isHidden = true
            user.email = EmailField.text
        }
        
        /*if EmailField.state.isEmpty{
            EmailField.placeholder = "Email required"
            emaiError.isHidden = false
        }*/
        
            
        
        checkForValidForm()
    }
    
  
    
    
    @IBAction func usernameChanged(_ sender: Any) {
        if let errorMessage = invalidUsername(UserNameField.text!)
          
        {
            usernameError.text = errorMessage
            usernameError.isHidden = false
        }
        else
        {
            usernameError.isHidden = true
            user.username = UserNameField.text
        }
            
        
        checkForValidForm()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let errorMessage = invalidPassword(PasswordField.text!)
          
        {
            passwordError.text = errorMessage
            passwordError.isHidden = false
        }
        else
        {
            passwordError.isHidden = true
            user.password = PasswordField.text
        }
        checkForValidForm()
    }
    
    
    
    func checkForValidForm(){
        if emaiError.isEnabled && usernameError.isHidden && passwordError.isHidden{
            SignUpButton.isEnabled = true
        }
        else
        {
            SignUpButton.isEnabled = false
        }
    }
    
    
    @IBAction func OnSignUpButton(_ sender: Any) {
        resetForm()
       
    }
    

    
    func invalidEmail(_ value: String) -> String? {
        let emailvalidation =  "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailvalidation)
        if !predicate.evaluate(with: value){
            return "Invalid Email Address"
        }
        if EmailField.state.isEmpty{
            EmailField.placeholder = "Email required"
        }
    
        
        return nil
    }
    
    
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
        if PasswordField.state.isEmpty{
            PasswordField.placeholder = "Password required"
        }
    
        /*if PasswordField.state.isEmpty{
            PasswordField.placeholder = "Password required"
            self.PasswordField.layer.borderColor = UIColor.blue.cgColor
            self.PasswordField.layer.borderWidth = 1
        }*/
       

            
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
    
    func FirstUpperCase(_ value: String) -> Bool {
        
        let upperCase = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", upperCase)
        return !predicate.evaluate(with: value)
    }
    
    func invalidUsername(_ value: String) -> String? {
        if value.count < 6 {
            return "Username must be at least 6 characters"
        }
        if UserNameField.state.isEmpty{
            UserNameField.placeholder = "Username required"
        }
        if UserNameField.state.isEmpty{
           UserNameField.placeholder = "Email required"
        }
    
        return nil
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
