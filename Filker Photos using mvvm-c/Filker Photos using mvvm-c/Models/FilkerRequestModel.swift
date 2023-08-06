//
//  FilkerRequestModel.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import Foundation

struct FilkerRequestModel:Encodable{
    private let method:String = "flickr.photos.search"
    private let format:String = "json"
    private let nojsoncallback:String = "50"
    private let text:String = "Color"
    private let page:Int
    private let per_page:Int = AppConstants.ServerInfo.imagesPerPage
    private let api_key:String
    
    internal init(page: Int) {
        self.page = page
        self.api_key = AppConstants.ServerInfo.apiKey()
    }
    
}
