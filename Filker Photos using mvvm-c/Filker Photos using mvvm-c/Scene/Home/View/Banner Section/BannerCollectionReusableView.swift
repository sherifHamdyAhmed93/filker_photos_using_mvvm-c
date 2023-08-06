//
//  BannerCollectionReusableView.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import UIKit

class BannerCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bannerImage:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerImage.layer.cornerRadius = 5
        bannerImage.layer.borderColor = UIColor.gray.cgColor
        bannerImage.layer.borderWidth = 1

    }
    
}
