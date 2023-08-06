//
//  ImageCollectionViewCell.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
    
    

}
