//
//  App.swift
//  VeganApp
//
//  Created by Tommaso Barbiero on 08/07/22.
//

import Foundation


// MARK: - API Matching Struct
struct Response: Decodable {
    let feed: Feed
}

// MARK: - All data needed
struct Feed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let name: Name
    let summary: Summary
    let price: Price
    let image: [Image]
    let id: ID
    
    enum CodingKeys: String,CodingKey {
        case name = "im:name"
        case price = "im:price"
        case image = "im:image"
        case summary, id
    }
}

struct Name: Decodable {
    let label: String
}

struct Summary: Decodable {
    let label: String
}

struct Price: Decodable {
    let label: String
}

struct Image: Decodable {
    let label: String
}

struct ID: Decodable {
    let label: String
    let attributes: IDAttributes
}

struct IDAttributes: Decodable {
    let id: String
    
    enum CodingKeys:String, CodingKey {
        case id = "im:id"
    }
}
