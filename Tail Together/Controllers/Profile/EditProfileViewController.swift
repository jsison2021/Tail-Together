//
//  EditProfileViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/26/22.
//

import UIKit
import Parse


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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

        self.newUsernameField.text = currentUser?.username
        self.genderField.text = currentUser?["Gender"] as? String
        self.newEmailField.text = currentUser?.email
        self.phoneNumberField.text = currentUser?["PhoneNumber"] as? String
        //resetForm()
        // Do any additional setup after loading the view.
        let imageFile = currentUser?["image"] as? PFFileObject
        if ((imageFile == nil)){
            
        }
        else{
            let urlString = imageFile?.url!
            let url = URL(string: urlString!)!
            self.PictureChange.af.setImage(withURL: url)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        PictureChange.image = scaledImage
        
        dismiss(animated: true)
    }
    
    @IBAction func updatePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        present(picker,animated: true, completion: nil)
    }
    
    @IBAction func UpdateProfileButton(_ sender: Any) {
        let imageData = PictureChange.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        currentUser?.email = newEmailField.text
        currentUser?.username = newUsernameField.text
        currentUser?["Gender"] = genderField.text
        currentUser?["PhoneNumber"] = phoneNumberField.text
        currentUser?["image"] = file
        currentUser?.saveInBackground{(success, error) in
            if success{
                self.performSegue(withIdentifier: "backToProfileSegue", sender: Any?.self)
                print("Success")
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))") //error sigh up
            }
        }
        
    }
    
    
    

        
}
