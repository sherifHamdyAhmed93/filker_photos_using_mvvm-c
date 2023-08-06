//
//  TableView + Collectionview.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import Foundation
import UIKit

protocol ReusableView {}
protocol ReusableNib {}

extension ReusableView where Self : UIView{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension ReusableNib{
    static  var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

//extension ReusableNib where Self : UITableViewCell {}
//extension ReusableNib where Self : UICollectionViewCell {}
extension ReusableNib where Self : UIView {}

extension UITableView{
    
    func dequeueReusableCell<T:UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}

extension UICollectionView{
    
     func dequeueReusableCell<T:UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell")
        }
        return cell
    }
}

extension UITableViewCell:ReusableView,ReusableNib {}
extension UICollectionViewCell:ReusableView,ReusableNib {}
extension UIView:ReusableNib {}
extension UITableViewHeaderFooterView:ReusableView,ReusableNib {}

extension UICollectionReusableView:ReusableView,ReusableNib {}
