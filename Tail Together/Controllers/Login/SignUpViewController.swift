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
    
    let user = PFUser() //Parse object declaration
    
    /* */
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
    
        resetForm() ///call reset form function
    }
    
    func resetForm(){
        
        /* Variables*/
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
        
        user["PhoneNumber"] = "(XXX)-XXX-XXXX"
        user["Gender"] = "N/A"
        
        //Sign up button perform this after checking for validate form
        user.signUpInBackground {(success, error) in
            if success{
                self.performSegue(withIdentifier: "GoTotheLoginScreen", sender: nil)//succes sign up
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))") //error sigh up
            }
        }
    }
    
    
    @IBAction func FnameChanged(_ sender: Any) {
        
        
        if let errorMessage = invalidFirstName(FirstName.text!) {
            FnameError.text = errorMessage
            FnameError.isHidden = false
        }
        else
        {
            FnameError.isHidden = true
            user["FirstName"] = FirstName.text //get first name from user save it to database
        }
        checkForValidForm()
    }
    
    
    @IBAction func LnameChanged(_ sender: Any) {
        
        if let errorMessage = invalidLastName(LastName.text!)
          
        {
            LnameError.text = errorMessage
            LnameError.isHidden = false
        }
        else
        {
            LnameError.isHidden = true
            user["LastName"] = LastName.text //get last name from user and save it to database
        }
        checkForValidForm()
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
        if emaiError.isHidden && usernameError.isHidden && passwordError.isHidden && FnameError.isHidden && LnameError.isHidden{
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
        return nil
    }
    
    func invalidFirstName(_ value: String) -> String? {
        
        if (FirstName.text!.isEmpty)
        {
           return "Enter your first name"
        }
        if Digit(value){
            return "First name must not contain digit"
        }
        if Special(value){
            return "First name must not contain special character"
        }
        return nil

    }
    
    func invalidLastName(_ value: String) -> String?{
        
        if LastName.text!.isEmpty{
           return "Enter your last name"
        }
        if Digit(value){
            return "Last name must not contain digit"
        }
        if Special(value){
            return "Last name must not contain special character"
        }
        return nil
    }
    
    func Digit(_ value: String) -> Bool {
        
        let digits = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", digits)
        return predicate.evaluate(with: value)
    }
    
    func Special(_ value: String) -> Bool {
        
        let sp = ".*[^A-Za-z0-9].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", sp)
        return predicate.evaluate(with: value)
    }

}
