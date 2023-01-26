//
//  EventDetailsTableViewController.swift
//  Tail Together
//
//  Created by Justin on 12/6/22.
//

import UIKit
import Parse

class EventDetailsTableViewController: UITableViewController {

    var firstName = ""
    var lastName = ""
    var date = ""
    var time = ""
    var desc = ""
    var eventText = ""
    var eventId = ""
    var comments = [PFObject]()
    var temp = [PFObject]()
    
   

    
    @IBOutlet weak var eventPoster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    
    @IBOutlet weak var addedButton: UIButton!
    @IBOutlet weak var newCommentField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.eventLabel.text = eventText
        self.nameLabel.text = firstName + " " + lastName
        self.dateLabel.text = date
        self.timeLabel.text = time
        self.descLabel.text = desc
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func findingData(){
       let query = PFQuery(className: "Comments")
       query.includeKeys(["events","commentText","author","createdAt"])
       query.whereKey("events", equalTo: eventId)
       query.addDescendingOrder("createdAt")
       query.findObjectsInBackground {(messages, error) in
           
           if messages != nil {
               self.comments = messages!
               self.tableView.reloadData()
           
           }
           
       }
   }
   override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
    
      
       findingData()
       
   }
    
    @IBAction func addingEvent(_ sender: Any) {
        let query = PFQuery(className: "Events")
        query.includeKeys(["events"])
        query.whereKey("objectId", equalTo: eventId)
        query.addDescendingOrder("createdAt")
    
        
        query.findObjectsInBackground {(messages, error) in
            if messages != nil {
                self.temp = messages!
                let addEvent = PFObject(className: "EventUser")
                
                addEvent["event"] = self.temp[0]
                addEvent["author"] = PFUser.current()!
             
                addEvent.saveInBackground{ (success,error) in
                    if success{
                        self.addedButton.setImage(UIImage(systemName: "checkmark"), for: UIControl.State.normal)
                        print("saved")
                    }
                    else{
                        print("error!")
                    }
                
                }
            
            }
             
        }
        
        
    }
    @IBAction func newCommentButton(_ sender: Any) {
        let commenting = PFObject(className: "Comments")
        
        commenting["commentText"] = newCommentField.text
        commenting["events"] = eventId
        commenting["author"] = PFUser.current()!
        
        commenting.saveInBackground{ (success,error) in
            if success{
                self.newCommentField.text = ""
                self.findingData()
                print("saved")
            }
            else{
                print("error!")
            }
        
        }
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           if segue.identifier == "goUserToProfile" {
               let secondVC: UserProfileViewController = segue.destination as! UserProfileViewController
               let cell = sender as! UITableViewCell
               let indexPath = tableView.indexPath(for: cell)

               let event = comments[indexPath!.row]
        
               let user = event["author"] as! PFUser
               
             
               
               
               secondVC.firstName = user["FirstName"] as! String
               secondVC.lastName = user["LastName"] as! String
               secondVC.email = user["email"] as? String ?? " "
               secondVC.phone = user["PhoneNumber"] as? String ?? ""
               secondVC.gender = user["Gender"] as? String ?? " "
               secondVC.user = user["username"] as? String ?? " "
               
               secondVC.objectId = user.objectId!
              
           }
       }

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }
  

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell

        
        // Configure the cell...
        let comment = comments[indexPath.row]
        let commentUser = comment["author"] as! PFUser
        let created = comment.createdAt
        
        cell.nameLabel.text = commentUser["username"] as? String
        cell.timeLabel.text = created?.formatted()
        cell.commentTextLabel.text = comment["commentText"] as? String
    
        return cell
    }
    
   
    

    @IBAction func goToProfile(_ sender: Any) {
        
        
       // self.performSegue(withIdentifier: "goUserToProfile", sender: Any?.self)
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
