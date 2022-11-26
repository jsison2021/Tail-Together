//
//  ProfileViewController.swift
//  Tail Together
//
//  Created by Justin on 11/23/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameText: UITextField!
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    let user = PFUser.current()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = user?["username"] as? String
        
        self.profilePicture = user?["image"] as? UIImageView
        self.firstNameText.text = user?["FirstName"] as? String
        self.lastNameText.text = user?["LastName"] as? String
        self.userNameText.text = user?["username"] as? String
        self.emailText.text = user?["email"] as? String

       // let imageFile = user?["image"] as! PFFileObject
        //let urlString = imageFile.url!
        //let url = URL(string: urlString)!
        
        //profilePicture.af.setImage(withURL: url)
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func onUpdateButton(_ sender: Any) {
        print("Working")
        
        user?["FirstName"] = self.firstNameText.text
        user?["LastName"] = self.lastNameText.text
        user?["username"] = self.userNameText.text
        user?["email"] = self.emailText.text
        
        let imageData = profilePicture.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
    
        user?["image"] = file
        user?.saveInBackground{ (success,error) in
            if success{
                self.dismiss(animated: true)
                
                print("saved")
            }
            else{
                print("error!")
            }
        
        }
        

        
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        print("Working")
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
 
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        profilePicture.image = scaledImage
        dismiss(animated: true)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "FirstViewController")
            
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
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
