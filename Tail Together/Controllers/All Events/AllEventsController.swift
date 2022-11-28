//
//  AllEventsController.swift
//  Tail Together
//
//  Created by Justin on 11/25/22.
//

import UIKit
import Parse

class AllEventsController: UITableViewController {

    var User = [PFUser].self
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
        let query = PFQuery(className: "Events")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
                           //, "timeText", "dateText", "descText", "nameText", "timeText.author", "dateText.author", "descText.author", "nameText.author"])
        query.limit = 20
        
        
        
        
        query.findObjectsInBackground{ (events,error) in
            if events != nil {
                self.events = events!
                self.tableView.reloadData()
               
            }
            
        }
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
       /* let event = events[section]
        let comments = (event["comments"] as? [PFObject]) ?? []
        return comments.count + 2
        let event = events[section]
        return 1*/
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 190
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        //let event = events[indexPath.section]
        
        let event = events[indexPath.row]
        let user = event["author"] as! PFUser
        
        cell.hostLabel.text = event["descText"] as? String
        cell.dataLabel.text = event["dateText"] as? String
        cell.timeLabel.text = event["timeText"] as? String
        cell.eventNameLabel.text = event["nameText"] as? String
        
        cell.firstName.text = user["FirstName"] as? String
        cell.lastName.text = user["LastName"] as? String
        
        let imageFile = user["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.profileImage.af.setImage(withURL: url)
        
        /*let imageFile = user["image"] as! PFFileObject
        
        
        
        
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.profileImage.af.setImage(withURL: url)
        
        if let profileImage = user["image"] {
            
            let postImagePFFile = profileImage as! PFFileObject
            
            postImagePFFile.getDataInBackground(block: {
                (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.profileImage.image = image
                    }
                }
            })
        }*/
        return cell
    }
       /* else
        {
            let urlString = ("https://media-exp1.licdn.com/dms/image/C4E03AQE6xmc94aGJ8A/profile-displayphoto-shrink_800_800/0/1659707946414?e=2147483647&v=beta&t=cSxby8W6DKQrkKcM0foc4KMkgGhJxprV5P-vTxF--bU")
            let url = URL(string: urlString)!
            /*var imageUrl = URL(string: "https://media-exp1.licdn.com/dms/image/C4E03AQE6xmc94aGJ8A/profile-displayphoto-shrink_800_800/0/1659707946414?e=2147483647&v=beta&t=cSxby8W6DKQrkKcM0foc4KMkgGhJxprV5P-vTxF--bU")*/
            cell.profileImage.af.setImage(withURL: url)
            //cell.profileImage.image = imageUrl)*/
        
            
    
    
    
    
    
    @IBAction func eventGesture(_ sender: Any) {
       /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let secondViewController = storyBoard.instantiateViewControllerWithIdentifier("secondView") as SecondViewController
                self.presentViewController(secondViewController, animated:true, completion:nil)
            */
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
