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
        
        //For description border
        descText!.layer.borderWidth = 1
        descText!.layer.borderColor = UIColor.darkGray.cgColor
        
        //Date Picking
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        
        dateText.inputView = datePicker
        dateText.text = formatDate(date: Date()) // todays Date
        // Do any additional setup after loading the view.
    }
    
    @objc func dateChange(datePicker: UIDatePicker)
        {
            dateText.text = formatDate(date: datePicker.date)
        }
    
    func formatDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd yyyy"
            return formatter.string(from: date)
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
                self.performSegue(withIdentifier: "NewEvent", sender: nil)
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
