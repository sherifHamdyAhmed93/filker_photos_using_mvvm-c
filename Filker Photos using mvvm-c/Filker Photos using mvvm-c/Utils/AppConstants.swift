//
//  AppConstants.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import Foundation

class AppConstants{
    static let emptyCollectionViewTag = 111
    private static let infoDict:[String:Any]? = {
        return Bundle.main.infoDictionary
    }()
    
    struct ServerInfo{
        static let baseURL = URL(string: "https://www.flickr.com/services/rest/?")!
        
        static let imagesPerPage:Int = 20
        
        enum keys{
            static let api_key = "API_KEY"
        }
        
        static let apiKey = {
            guard let apiKeyString = AppConstants.infoDict?[AppConstants.ServerInfo.keys.api_key] as? String else{
                return ""
            }
            return apiKeyString
        }
    }
    
    
    
}
