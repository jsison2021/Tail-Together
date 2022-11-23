//
//  MessageCell.swift
//  Tail Together
//
//  Created by Michelob Revol on 11/2/22.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var MessageProfile: UIImageView!
    
    @IBOutlet weak var FirstName: UILabel!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var timeMessage: UILabel!
    
    @IBOutlet weak var DateMessage: UILabel!
    @IBOutlet weak var LastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       MessageProfile.layer.cornerRadius = MessageProfile.layer.bounds.width / 2
        MessageProfile.clipsToBounds = true
        MessageProfile.layer.borderColor = UIColor.darkGray.cgColor
        MessageProfile.layer.borderWidth = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
