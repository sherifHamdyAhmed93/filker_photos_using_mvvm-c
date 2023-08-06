//
//  JsonHandler.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import Foundation

class JsonHandler<T:Codable>{
    func parseData(data:Data) throws ->  T{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(T.self, from: data)
            return response
        }catch{
            throw error
        }
    }
    
}
