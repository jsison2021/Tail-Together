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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func newMessageButton(_ sender: Any) {
        print("doing something")
    }
    
    @IBOutlet weak var statusButton: UIButton!
    @IBAction func searchBar(_ sender: Any) {

        let query = PFUser.query()
        
        query?.findObjectsInBackground {(object, error) in
            if let users = object as? [PFUser] {
                let filteredUsers = users.filter { $0.username!.contains(self.searchField.text!) }
                
                self.resultLabel.text = filteredUsers.first?["username"] as? String
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
