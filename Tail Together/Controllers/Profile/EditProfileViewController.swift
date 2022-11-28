//
//  EditProfileViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/26/22.
//

import UIKit
import Parse



class EditProfileViewController: UIViewController {

    @IBOutlet weak var UpdateButton: UIBarButtonItem!
    
    @IBOutlet weak var PictureChange: UIImageView!
    @IBOutlet weak var newUsernameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    let currentUser = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PictureChange.layer.cornerRadius = PictureChange.layer.bounds.width / 2
        PictureChange.clipsToBounds = true
        PictureChange.layer.borderColor = UIColor.orange.cgColor
        PictureChange.layer.borderWidth = 2.0

        //resetForm()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func UpdateProfileButton(_ sender: Any) {
        
        
        currentUser?.email = newEmailField.text
        currentUser?.username = newUsernameField.text
        
        currentUser?["Gender"] = genderField.text
      
        currentUser?["Gender"] = phoneNumberField.text

        currentUser?.saveInBackground{(success, error) in
            if success{
                
                let main = UIStoryboard(name: "Main", bundle: nil)
                let ProfileViewController2 = main.instantiateViewController(withIdentifier: "ProfileViewController2")
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return} // check window
                delegate.window?.rootViewController = ProfileViewController2
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))") //error sigh up
            }
        }
        
    }
    
    
    
    @IBAction func usernameChanged(_ sender: Any) {
    }
    
    @IBAction func genderChanged(_ sender: Any) {
    }
    
    
    

    
    @IBAction func emailChanged(_ sender: Any) {
        

    }
    
   
    
    @IBAction func phoneNumberChanged(_ sender: Any) {
        
    }
        
}
