//
//  Character.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 23.10.2023.
//

import Foundation

struct Character: Codable, Equatable {
    let url: String
    let name, gender, culture, born: String
    let died: String
    let titles, aliases: [String]
    let father, mother: String
    let spouse: String
    let allegiances, books, povBooks: [String]
    let tvSeries, playedBy: [String]
}
