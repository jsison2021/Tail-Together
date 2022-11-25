//
//  CreateEventViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/24/22.
//

import UIKit
import Parse

class CreateEventViewController: UIViewController {
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var timeText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descText!.layer.borderWidth = 1
        descText!.layer.borderColor = UIColor.darkGray.cgColor
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createButton(_ sender: Any) {
        let event = PFObject(className: "Events")
        
        event["timeText"] = timeText.text!
        event["dateText"] = dateText.text!
        event["descText"] = descText.text!
        event["nameText"] = nameText.text!
        event["author"] = PFUser.current()!
        
        event.saveInBackground{ (success,error) in
            if success{
                self.dismiss(animated: true)

                print("saved")
            }
            else{
                print("error!")
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
