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
    
    var messagesArray = [PFObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Messages")
        query.includeKeys(["user"])
        
        query.limit = 20
        
        query.findObjectsInBackground {(MessagesArray, error) in
            if self.messagesArray != nil{
                self.messagesArray = self.messagesArray
                self.tableView.reloadData()
    
            }
        }

    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        let MessageArray = messagesArray[indexPath.row]
        
        
        let user = MessageArray["owner"] as? PFUser
      
        cell.FirstName.text = user?["FirstName"] as? String
        cell.LastName.text = user?["LastName"] as? String
        cell.textMessage.text = " I just want to know if you there"
    
        
        
        return cell
    }
    
}
