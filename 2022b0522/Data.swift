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

struct Data2 : Codable{
    var conversation : Conversation
}
struct Conversation : Codable{
    let keyword : String
    let response : String
}
/*
 {
   "conversation": {
     "keyword" : "안녕하세요",
     "response" : "네, 안녕하세요"
   }
 }

 */
