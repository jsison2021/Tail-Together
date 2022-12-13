//
//  UserProfileViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 12/10/22.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController {

    
    
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var UserGender: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    
    
  
    
    
    var firstName = ""
    var lastName = ""
    var gender = ""
    var email = " "
    var profile = ""
    var phone = ""
    var user = ""
    var objectId = ""
    var filteredUsers = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userFirstName.text = firstName
        self.userLastName.text = lastName
        self.userEmail.text = email
        self.userName.text = user
        self.UserGender.text = gender
        self.userPhone.text = phone
        
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: objectId)
        query?.findObjectsInBackground {(object, error) in
            
    
            self.filteredUsers = object!
            
        }
    
 
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func messageButton(_ sender: Any) {
        let query = PFQuery(className: "Conversations")

        //query.whereKey("Account1", equalTo: PFUser.current()!)
        query.whereKey("Account2", equalTo: PFUser.current()!)
        
       
        query.findObjectsInBackground { (object, error) -> Void in
              
              if object == [] {
                  let convo = PFObject(className: "Conversations")
                  let messages  = PFObject(className: "Messages")
                  let relation = convo.relation(forKey: "authors")
                  relation.add(self.filteredUsers.first!)
                  relation.add(PFUser.current()!)
                  convo["Account1"] = PFUser.current()!
                  convo["Account2"] = self.filteredUsers.first!
                  
                  convo.add(messages, forKey: "messages")
                  
                  
                  convo.saveInBackground{ (success,error) in
                      if success{
                          
                          print("saved")
                      }
                      else{
                          print("error!")
                      }
                  
                  }
              } else {
                  print("it exists")
              }

          }
        
        self.performSegue(withIdentifier: "profileToMessage", sender: Any?.self)
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
