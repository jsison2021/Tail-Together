//
//  EventCell.swift
//  Tail Together
//
//  Created by Justin on 11/25/22.
//

import UIKit

class EventCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.orange.cgColor
        profileImage.layer.borderWidth = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
