//
//  CollectionView+Extensions.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import UIKit

extension UICollectionView{
    func addRefresherToCollectionView(){
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
    }
    
}
