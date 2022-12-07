//
//  CreateEventViewController.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/24/22.
//

import UIKit
import Parse

class CreateEventViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var timeText: UITextField!
    
    @IBOutlet weak var eventPicture: UIImageView!
    
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
        
        //Time Picking
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChange(timePicker:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 300)
        timePicker.preferredDatePickerStyle = .wheels
     
        
        timeText.inputView = timePicker
        timeText.text = formatTime(date: Date()) // todays Date
        
    
    }
    
    @objc func dateChange(datePicker: UIDatePicker)
        {
            dateText.text = formatDate(date: datePicker.date)
        }
    @objc func timeChange(timePicker: UIDatePicker)
        {
            timeText.text = formatTime(date: timePicker.date)
        }
    
    func formatDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd yyyy"
            return formatter.string(from: date)
        }
    
    func formatTime(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm:a zzz"
            return formatter.string(from: date)
        }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        eventPicture.image = scaledImage
        
        dismiss(animated: true)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        present(picker,animated: true, completion: nil)
        
        
    }
    @IBAction func createButton(_ sender: Any) {
        let event = PFObject(className: "Events")
        
        let imageData = eventPicture.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        event["image"] = file
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
