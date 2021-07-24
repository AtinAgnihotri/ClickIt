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
        clickedImage.translatesAutoresizingMaskIntoConstraints = false
        caption.translatesAutoresizingMaskIntoConstraints = false
//        clickedImage.contentMode = .scaleAspectFit
//        clickedImage.autoresizesSubviews = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
//    func setupCell(caption: String, image: String) {
//        captionLabel.text = caption
//        let imagePath = PersistenceManager
//            .shared
//            .getDocumentsDirectory()
//            .appendingPathComponent(image)
//        clickedImage.image = UIImage(contentsOfFile: imagePath.path)
//    }

}
