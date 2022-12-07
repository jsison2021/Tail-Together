//
//  MyEventsTableViewController.swift
//  Tail Together
//
//  Created by Justin on 12/7/22.
//

import UIKit
import Parse
class MyEventsTableViewController: UITableViewController {

    var events = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "EventUser")
        query.order(byDescending: "createdAt")
        query.includeKeys(["author","event","event.author","event.nameText"])
        query.whereKey("author", equalTo: PFUser.current()!)
        
        query.findObjectsInBackground{ (events,error) in
            
            if events != nil {
                self.events = events!
                self.tableView.reloadData()
               
            }
            
        }
       
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           if segue.identifier == "myEventSegue" {
               let secondVC: EventDetailsTableViewController = segue.destination as! EventDetailsTableViewController
               let cell = sender as! UITableViewCell
               let indexPath = tableView.indexPath(for: cell)

               let enrolled = events[indexPath!.row]
               let event =  enrolled["event"] as! PFObject
               let user = event["author"] as! PFUser
               
               secondVC.firstName = user["FirstName"] as! String
               secondVC.lastName = user["LastName"] as! String
               secondVC.date = event["dateText"] as! String
               secondVC.time = event["timeText"] as! String
               secondVC.desc = event["descText"] as! String
               secondVC.eventText = event["nameText"] as! String
               secondVC.eventId = event.objectId!
           }
       }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell

        // Configure the cell...
        let enrolled = events[indexPath.row]
        let event =  enrolled["event"] as! PFObject
        let user = event["author"] as! PFUser
        
        cell.hostLabel.text = event["descText"] as? String
        cell.dataLabel.text = event["dateText"] as? String
        cell.timeLabel.text = event["timeText"] as? String
        cell.eventNameLabel.text = event["nameText"] as? String
        
        cell.firstName.text = user["FirstName"] as? String
        cell.lastName.text = user["LastName"] as? String
        
        let imageFile = user["image"] as? PFFileObject
        if ((imageFile == nil)){
        }
        if ((imageFile != nil)){
            let urlString = imageFile?.url!
            let url = URL(string: urlString!)!
            cell.profileImage.af.setImage(withURL: url)
        }
        let imageFile2 = event["image"] as? PFFileObject
        if ((imageFile2 == nil)){
            
        }
        if ((imageFile2 != nil)){
            let urlString = imageFile2?.url!
            let url = URL(string: urlString!)!
            cell.eventImage.af.setImage(withURL: url)
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
