//
//  NewMessageViewController.swift
//  Tail Together
//
//  Created by Justin on 11/28/22.
//

import UIKit
import Parse

class NewMessageViewController: UIViewController {
  
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    var filteredUsers = [PFUser()]
    var temp = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func newMessageButton(_ sender: Any) {
        
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
        
        // suppose we have a user we want to follow
        // create an entry in the Follow table
    }
    
    
    @IBOutlet weak var statusButton: UIButton!
    @IBAction func searchBar(_ sender: Any) {

        let query = PFUser.query()
        
        query?.findObjectsInBackground {(object, error) in
            if let users = object as? [PFUser] {
                self.filteredUsers = users.filter { $0.username!.contains(self.searchField.text!) }
                
                self.resultLabel.text = self.filteredUsers.first?["username"] as? String
                if (self.resultLabel.text == nil) {
                    
                    self.statusButton.isHidden = true
                }
                else{
                    self.statusButton.isHidden = false
                }
                
                
            }
        }
        
        
        
       
       
        
       
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
