//
//  Book.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 23.10.2023.
//

import Foundation

struct Book: Codable, Equatable {
    let url: String
    let name, isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType, released: String
    let characters, povCharacters: [String]
}

extension Book {
    static let mock: Book = Book(url: "https://anapioficeandfire.com/api/books/1",
                                 name: "A Game of Thrones",
                                 isbn: "978-0553103540",
                                 authors: ["George R. R. Martin"],
                                 numberOfPages: 694,
                                 publisher: "Bantam Books",
                                 country: "United States",
                                 mediaType: "Hardcover",
                                 released: "1996-08-01T00:00:00",
                                 characters: ["https://anapioficeandfire.com/api/characters/2",
                                              "https://anapioficeandfire.com/api/characters/12"],
                                 povCharacters: ["https://anapioficeandfire.com/api/characters/148",
                                                 "https://anapioficeandfire.com/api/characters/208"])
}
