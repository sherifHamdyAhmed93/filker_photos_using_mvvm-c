//
//  Banner.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import Foundation

struct Banner{
    let id:String = UUID().uuidString
    var photosData:[PhotoViewModel] = []

}

extension Banner:Hashable{
    static func == (lhs: Banner, rhs: Banner) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
