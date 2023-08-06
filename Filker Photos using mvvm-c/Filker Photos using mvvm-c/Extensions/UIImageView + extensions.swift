//
//  UIImageView + extensions.swift
//  Filker Photos using mvvm-c
//
//  Created by Sherif Hamdy on 06/08/2023.
//

import UIKit

extension UIImageView{
    func loadImage(fromURL url: URL, forKey key: String, completion: @escaping ImageCompletionHandler) {
       
        ImageCacheManager.shared.image(forKey: url, completion:{ image in
            if let image = image{
                completion(image)
            }else{
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        debugPrint("image not cached")
                        ImageCacheManager.shared.cache(image: image, forKey: url)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }.resume()
            }
        })
        
        
    }
}
