//
//  Photo.swift
//
//  Created by Sherif Hamdy on 05/08/2023
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Photo: Codable {

  enum CodingKeys: String, CodingKey {
    case farm
    case server
    case isfamily
    case isfriend
    case ispublic
    case owner
    case title
    case secret
    case id
  }

  var farm: Int?
  var server: String?
  var isfamily: Int?
  var isfriend: Int?
  var ispublic: Int?
  var owner: String?
  var title: String?
  var secret: String?
  var id: String?

   

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    farm = try container.decodeIfPresent(Int.self, forKey: .farm)
    server = try container.decodeIfPresent(String.self, forKey: .server)
    isfamily = try container.decodeIfPresent(Int.self, forKey: .isfamily)
    isfriend = try container.decodeIfPresent(Int.self, forKey: .isfriend)
    ispublic = try container.decodeIfPresent(Int.self, forKey: .ispublic)
    owner = try container.decodeIfPresent(String.self, forKey: .owner)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    secret = try container.decodeIfPresent(String.self, forKey: .secret)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
