//
//  MessageLogTableViewController.swift
//  Tail Together
//
//  Created by Justin on 12/6/22.
//

import UIKit
import Parse


class MessageLogTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let bubbleBackgtoundView = UIView.self
    var firstName = ""
    var lastName = ""
    var objectId = ""
    
   
    var messages = [PFObject]()
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var newMessageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        newMessageField.layer.borderWidth = 1
        newMessageField.layer.borderColor = UIColor.orange.cgColor
        
        
        tableView.separatorStyle = .none
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
                self.newMessageField.text = ""
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
            
            cell.layer.cornerRadius = 30
            cell.backgroundColor = .link
            cell.messageField.textColor = .white
            cell.messageField.font = .systemFont(ofSize: 18)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
         
            cell.createdText.textAlignment = NSTextAlignment(.right)
            cell.createdText.text = created?.formatted()
            
            
            
            /*let constraint = [cell.topAnchor.constraint(equalTo: cell.messageField.topAnchor, constant: 16),cell.trailingAnchor.constraint(equalTo: cell.messageField.trailingAnchor, constant: 30), cell.bottomAnchor.constraint(equalTo: cell.messageField.bottomAnchor, constant: -16), cell.widthAnchor.constraint(equalTo: cell.messageField.widthAnchor, constant: 150)]
            NSLayoutConstraint.activate(constraint)*/
            
            
           
        }
        if (messageUser.objectId != PFUser.current()?.objectId){
            
            
            cell.messageField.textAlignment = NSTextAlignment(.left)
            cell.messageField.text = message["messageText"] as? String
            
           
            
            //cell.layer.cornerRadius = 30
            cell.backgroundColor = .lightGray
            cell.messageField.textColor = .black
            cell.messageField.font = .systemFont(ofSize: 18)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 30
        
            
            
            cell.createdText.textAlignment = NSTextAlignment(.left)
            cell.createdText.text = created?.formatted()
            
            cell.messageField.translatesAutoresizingMaskIntoConstraints = false
            
            //bubbleBackgtoundView.backgroundColor = .yellow
            cell.messageField.backgroundColor = .lightGray
            //cell.messageField.addSubview(cell.messageField)
            
            
            
            
            /*let constraint = [cell.topAnchor.constraint(equalTo: cell.messageField.topAnchor, constant: 16),cell.leadingAnchor.constraint(equalTo: cell.messageField.leadingAnchor, constant: 30), cell.bottomAnchor.constraint(equalTo: cell.messageField.bottomAnchor, constant: -16), cell.widthAnchor.constraint(equalTo: cell.messageField.widthAnchor, constant: 150)]
            NSLayoutConstraint.activate(constraint)*/
            
        }
        
       
        return cell
    }

    
    @IBAction func viewProfileGesture(_ sender: Any) {
        
        
  
        
   /* print("Huxley Gesture")
        let main = UIStoryboard(name: "Main", bundle: nil)
        let UserProfileViewController = main.instantiateViewController(identifier: "UserProfileViewController")
            
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = UserProfileViewController
        self.present(UserProfileViewController, animated:true, completion:nil)*/
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
