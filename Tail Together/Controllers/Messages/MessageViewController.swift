//
//  MessageViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/2/22.
//

import UIKit
import Parse
import Alamofire

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [PFObject]()
    var otherUsers = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
    }
    
    // MARK: - Table view data source
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Conversations")
        query.includeKeys(["Account1","Account2","messages"])
        query.whereKey("authors", equalTo: PFUser.current()!)
        
        
        query.findObjectsInBackground {(messages, error) in
            if messages != nil {
                self.messages = messages!
                self.tableView.reloadData()
            
            }
            
        }
        

    }
    
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
           if segue.identifier == "viewMessage" {
               let secondVC: MessageLogTableViewController = segue.destination as! MessageLogTableViewController
               let cell = sender as! UITableViewCell
               let indexPath = tableView.indexPath(for: cell)

               let message = messages[indexPath!.row]
        
               let user = message["Account2"] as? PFUser
               let currentUser = PFUser.current()
            
               
               if (user?.objectId == currentUser?.objectId){
                   let otherUser = message["Account1"] as? PFUser
                
                   secondVC.firstName = otherUser?["FirstName"] as! String
                   secondVC.lastName = otherUser?["LastName"] as! String
                   secondVC.objectId = message.objectId!
                  
               }
               if (user?.objectId != currentUser?.objectId){
                   
                   secondVC.firstName = user?["FirstName"] as! String
                   secondVC.lastName = user?["LastName"] as! String
                   secondVC.objectId = message.objectId!
               }
           }
       }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return messages.count
           
       }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        print(messages)
    
        
        
        
          
        let message = messages[indexPath.row]
        let user = message["Account2"] as? PFUser
        let currentUser = PFUser.current()
     
        //let lastElement = message.objectId?.last
    
        //print(lastElement!)
        
        if (user?.objectId == currentUser?.objectId){
            let otherUser = message["Account1"] as? PFUser
            cell.FirstName.text = otherUser?["FirstName"] as? String
            cell.LastName.text = otherUser?["LastName"] as? String
            cell.DateMessage.text = message.updatedAt?.formatted()
            
            //let MessageCount = messages.count-1
            //let lastElement = messages[MessageCount]
            

           cell.textMessage.text = "We need to check this out to display the last message that the use sent"
            
            
            let imageFile = otherUser?["image"] as? PFFileObject
            if ((imageFile == nil)){
                }
            else{
                let urlString = imageFile?.url!
                let url = URL(string: urlString!)!
                cell.MessageProfile.af.setImage(withURL: url)
            }
        }
        if (user?.objectId != currentUser?.objectId){
            cell.FirstName.text = user?["FirstName"] as? String
            cell.LastName.text = user?["LastName"] as? String
            let imageFile = user?["image"] as? PFFileObject
            if ((imageFile == nil)){
                
            }
            else{
                let urlString = imageFile?.url!
                let url = URL(string: urlString!)!
                cell.MessageProfile.af.setImage(withURL: url)
            }
        }
          return cell
      }

}
