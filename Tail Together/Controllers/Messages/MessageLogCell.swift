//
//  MessageLogCell.swift
//  Tail Together
//
//  Created by Justin on 12/6/22.
//

import UIKit

class MessageLogCell: UITableViewCell {


    @IBOutlet weak var messageField: UILabel!
    
    @IBOutlet weak var createdText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
