//
//  MessageViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/2/22.
//

import UIKit
import Parse


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
        query.includeKeys(["Account1","Account2"]);
        
        query.findObjectsInBackground{ (otherUsers,error) in
            if otherUsers != nil {
                self.otherUsers = otherUsers!
                self.tableView.reloadData()
               
            }
            
        }
        
        let queryTwo = PFQuery(className: "Conversations")
        queryTwo.whereKey("authors", equalTo: PFUser.current()!)
        
        queryTwo.findObjectsInBackground {(messages, error) in
            if messages != nil {
                self.messages = messages!
                self.tableView.reloadData()
            
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return messages.count
           
       }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
          
        
          let message = messages[indexPath.row]
        
      //  print(otherUsers["Account1"])
         
          
         
          //cell.FirstName.text = message["FirstName"] as? String
         // cell.LastName.text = message["LastName"] as? String
         
      
          
          
          return cell
      }
}
