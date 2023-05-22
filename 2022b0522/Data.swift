//
//  Data.swift
//  2022b0522
//
//  Created by hokyun Kim on 2023/05/22.
//

import Foundation

struct Data :Codable{
    var groupMember : [Group]
}

struct Group :Codable{
    let group_id :String
    let group_name : String
    let member : [Member]
}

struct Member : Codable{
    let id : String
    let name : String
    let imageFile : String
}
