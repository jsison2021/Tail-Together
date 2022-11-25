//
//  ProfileViewController.swift
//  Tail Together
//
//  Created by Justin on 11/23/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameText: UITextField!
    
    let user = PFUser.current()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = user?["username"] as? String
        self.firstNameText.text = user?["FirstName"] as? String
        self.lastNameText.text = user?["LastName"] as? String
        self.userNameText.text = user?["username"] as? String
        self.emailText.text = user?["email"] as? String

        
        // Do any additional setup after loading the view.
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
