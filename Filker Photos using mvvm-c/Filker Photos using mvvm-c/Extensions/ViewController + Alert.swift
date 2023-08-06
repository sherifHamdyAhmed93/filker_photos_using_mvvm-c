//
//  ViewController + Alert.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import UIKit


extension UIViewController{
    func showDefaultAlert(title:String,message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
