//
//  ProfileViewController.swift
//  Tail Together
//
//  Created by Justin on 11/23/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController2: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var profilePicture2: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel! 
    @IBOutlet weak var detailsLabel: UIView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    let currentUser = PFUser.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Round Profile picture
        profilePicture2.layer.cornerRadius = profilePicture2.layer.bounds.width / 2
        profilePicture2.clipsToBounds = true
        profilePicture2.layer.borderColor = UIColor.orange.cgColor
        profilePicture2.layer.borderWidth = 2.0
        
        
        
        //Get user info from Database
        self.firstNameLabel.text = currentUser?["FirstName"] as? String
        self.lastNameLabel.text = currentUser?["LastName"] as? String
        self.usernameLabel.text = currentUser?.username
        
        let phone = currentUser?["PhoneNumbber"] as? String
        let gender = currentUser?["Gender"] as? String
    
        if phone != nil{
            self.phoneNumberLabel.text = phone
        }
        else
        {
            self.phoneNumberLabel.text = "(XXX)-XXX-XXXX"
        }
        
        if gender != nil{
            self.gender.text = gender
        }
        else
        {
            self.gender.text = "N/A"
        }
      
        
        
        self.emailLabel.text = currentUser?.email
       
       //get user profile picture
        let imageFile = currentUser?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        self.profilePicture2.af.setImage(withURL: url)
    }
    
    
    
    @IBAction func PictureUpdate(_ sender: Any) {
        
        //Update Profile picture
        let imageData = profilePicture2.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        currentUser?["image"] = file
        
        currentUser?.saveInBackground {(success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Photo Profile saved")
                let main = UIStoryboard(name: "Main", bundle: nil)
                let ProfileViewController2 = main.instantiateViewController(withIdentifier: "ProfileViewController2")
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return} // check window
                delegate.window?.rootViewController = ProfileViewController2
            }
            else
            {
                print("error!")
            }
        }
    }

    
    @IBAction func onUpdateButton(_ sender: Any) {
        /*print("Working")
        
        user?["FirstName"] = self.firstNameText.text
        user?["LastName"] = self.lastNameText.text
        user?["username"] = self.userNameText.text
        user?["email"] = self.emailText.text
        
        //let imageData = profilePicture.image!.pngData()
       // let file = PFFileObject(name: "image.png", data: imageData!)
    
        //user?["image"] = file
        user?.saveInBackground{ (success,error) in
            if success{
                self.dismiss(animated: true)
                
                print("saved")
            }
            else{
                print("error!")
            }
        
        }*/
        

        
    }
    
    @IBAction func onCameraButton2(_ sender: Any) {
        print("Working")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
           // picker.sourceType = .camera
            picker.sourceType = .photoLibrary
        }
        else{
            picker.sourceType = .photoLibrary
        }
        present(picker,animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 180, height: 180)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profilePicture2.image = scaledImage
        dismiss(animated: true, completion: nil)
    
    }
    
    
    @IBAction func editProfileButton(_ sender: Any) {
        
    }
    
    
   @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "FirstViewController")
            
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
 
}
