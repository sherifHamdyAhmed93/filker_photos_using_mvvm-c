//
//  AppError.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import Foundation

enum AppErrors:Error{
    case noDataFound

    var localizedDescription:String{
        switch self {
        case .noDataFound:
            return "No Data Found"
        }
    }
    
}
