//
//  Photos.swift
//
//  Created by Sherif Hamdy on 05/08/2023
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Photos: Codable {

  enum CodingKeys: String, CodingKey {
    case pages
    case total
    case page
    case photo
    case perpage
  }

  var pages: Int?
  var total: Int?
  var page: Int?
  var photo: [Photo]?
  var perpage: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    pages = try container.decodeIfPresent(Int.self, forKey: .pages)
    total = try container.decodeIfPresent(Int.self, forKey: .total)
    page = try container.decodeIfPresent(Int.self, forKey: .page)
    photo = try container.decodeIfPresent([Photo].self, forKey: .photo)
    perpage = try container.decodeIfPresent(Int.self, forKey: .perpage)
  }

}
