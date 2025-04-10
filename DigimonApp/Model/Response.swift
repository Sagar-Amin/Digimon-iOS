//
//  Response.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

struct Digimon: Decodable {
    let name: String
    let img: String
    let level: String
}

extension Digimon: Identifiable {
    var id: String {
        return name + img
    }
}
