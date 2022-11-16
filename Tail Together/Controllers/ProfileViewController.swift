//
//  ProfileViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/2/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CameraPicture: UIImageView!
    @IBOutlet weak var FirstName: UILabel!
    @IBOutlet weak var Lastname: UILabel!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioDescription: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var EmailDescription: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var EventTitle: UILabel!
    @IBOutlet weak var PictureChsngeButton: UIButton!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImage.layer.cornerRadius = ProfileImage.layer.bounds.width / 2
        ProfileImage.clipsToBounds = true
        ProfileImage.layer.borderColor = UIColor.darkGray.cgColor
        ProfileImage.layer.borderWidth = 2.0
        
        CameraPicture.layer.cornerRadius = CameraPicture.layer.bounds.width / 2
       CameraPicture.clipsToBounds = true
        ProfileImage.layer.borderColor = UIColor.gray.cgColor
        CameraPicture.layer.borderWidth = 2.0
        
        // Do any additional setup after loading the view.
        
        bioDescription.numberOfLines = 0

        
        let editProfile = PFObject(className: "ProfileTable") //table namw
        editProfile["user"] = PFUser.current()!
        let user = editProfile["user"] as! PFUser
        FirstName.text = user["FirstName"] as? String
        Lastname.text = user["LastName"] as? String
        Username.text = user.username
        EmailDescription.text = user.email
        bioDescription.text = "Je suis ici juste pour pouvoir aller a quelques event"
        bioDescription.sizeToFit()
        bioDescription.setNeedsDisplay()
        PhoneNumber.text = user["PhoneNumber"] as? String
        
        
    }
    
    
    
    @IBAction func ChangeProfileButton(_ sender: Any) {
        
        let editProfilePicture = PFObject(className: "ProfilePicture") //table namw
        editProfilePicture["user"] = PFUser.current()!
        let ProfileData = ProfileImage.image!.pngData() //change image to an png image
        let file = PFFileObject(name: "ProfileImage.png", data: ProfileData!)
        
        
        editProfilePicture["ProfilePicture"] = file
        
        editProfilePicture.saveInBackground {(success, error) in
            if success{
                
                self.dismiss(animated: true, completion: nil)
                print("Photo Profile saved")
                let main = UIStoryboard(name: "Main", bundle: nil)
                let ProfileViewController = main.instantiateViewController(withIdentifier: "ProfileViewController")
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return} // check window
                delegate.window?.rootViewController = ProfileViewController
                
            }
            else
            {
                print("error!")
            }
        }
    }
    
    
    
    @IBAction func ChangeProfilePicture(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //picker.sourceType = .camera
            picker.sourceType = .photoLibrary
        }
        else
        {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 80, height: 80)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        ProfileImage.image = scaledImage
        dismiss(animated: true, completion: nil)
        
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
