//
//  PhotoViewModel.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import Foundation

class PhotoViewModel{
    private let photo:Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var imageURL:String?{
        guard let farmId = photo.farm , let serverId = photo.server , let id = photo.id , let secret = photo.secret else{
            return nil
        }
        
        let urlString = String(format: "http://farm%d.static.flickr.com/%@/%@_%@.jpg", farmId,serverId,id,secret)
        return urlString
    }
    
    var imageTitle:String{
        return photo.title ?? ""
    }

}

extension PhotoViewModel:Hashable{
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        lhs.photo.id == rhs.photo.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(photo.id)
    }
    
}
