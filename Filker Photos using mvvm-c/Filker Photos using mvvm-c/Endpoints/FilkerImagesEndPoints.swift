//
//  FilkerImagesEndPoints.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import Alamofire

enum FilkerImagesEndPoints:URLRequestBuilder{
    
    case getImages(page:Int)
    
    
    var parameters: Parameters? {
        switch self {
        case .getImages(let page):
            return FilkerRequestModel(page: page).dictionary
        }
    }
    
    var path: String {
        switch self {
        case .getImages:
            return ""
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getImages:
            return .get
        }
    }
}
