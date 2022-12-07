//
//  MessageLogTableViewController.swift
//  Tail Together
//
//  Created by Justin on 12/6/22.
//

import UIKit
import Parse


class MessageLogTableViewController: UITableViewController {

    //var message = PFObject()
    var firstName = ""
    var lastName = ""
    var objectId = ""
  
    var messageView: [()] = [()]
    var messages = [PFObject]()
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var newMessageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.nameLabel.text = firstName + " " + lastName
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
 
     func findingData(){
        let query = PFQuery(className: "Messages")
        query.includeKeys(["conversations","messageText","author","createdAt"])
        query.whereKey("conversations", equalTo: objectId)
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground {(messages, error) in
            
            if messages != nil {
                self.messages = messages!
                self.tableView.reloadData()
            
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        findingData()
        
    }
    // MARK: - Table view data source

    @IBAction func sendMessage(_ sender: Any) {
        let newMessage = PFObject(className: "Messages")
        
        newMessage["messageText"] = newMessageField.text
        newMessage["conversations"] = objectId
        newMessage["author"] = PFUser.current()!
        
        newMessage.saveInBackground{ (success,error) in
            if success{
               
                self.findingData()
                print("saved")
            }
            else{
                print("error!")
            }
        
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageLogCell") as! MessageLogCell

        // Configure the cell...
        let message = messages[indexPath.row]
        
        let created = message.createdAt
        
        
        let messageUser = message["author"] as! PFUser
        
      
        if (messageUser.objectId == PFUser.current()?.objectId){
            cell.messageField.textAlignment = NSTextAlignment(.right)
            cell.messageField.text = message["messageText"] as? String
            
            cell.createdText.textAlignment = NSTextAlignment(.right)
            cell.createdText.text = created?.formatted()
        }
        if (messageUser.objectId != PFUser.current()?.objectId){
            cell.messageField.textAlignment = NSTextAlignment(.left)
            cell.messageField.text = message["messageText"] as? String
            
            cell.createdText.textAlignment = NSTextAlignment(.left)
            cell.createdText.text = created?.formatted()
        }
        
       
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
