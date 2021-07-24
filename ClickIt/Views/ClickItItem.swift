//
//  ClickItItems.swift
//  ClickIt
//
//  Created by Atin Agnihotri on 24/07/21.
//

import UIKit

class ClickItItem: UITableViewCell {
    
    @IBOutlet var clickedImage: UIImageView!
    @IBOutlet var caption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
