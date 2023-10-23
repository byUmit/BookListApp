//
//  BookClient.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 23.10.2023.
//

import ComposableArchitecture
import Foundation

struct BookClient {
    var fetchCharacters: ([String]) async throws -> [Character]?
}

extension BookClient: DependencyKey {
    static var liveValue: BookClient = Self(
        fetchCharacters: { urls in
            let characters: [Character?] = try await arrayRequest(for: urls)
            return characters.compactMap({ $0 })
        }
    )
}

extension DependencyValues {
    var bookClient: BookClient {
        get { self[BookClient.self] }
        set { self[BookClient.self] = newValue }
    }
}

extension BookClient {
    private static func arrayRequest<T: Codable>(for links: [String]) async throws -> [T?] {
        let results: [T?] = try await withThrowingTaskGroup(of: T?.self) { group in
            for link in links {
                group.addTask {
                    do {
                        guard let linkURL = URL(string: link) else { return nil }
                        let (data, _) = try await URLSession.shared.data(from: linkURL)
                        let model = try JSONDecoder().decode(T.self, from: data)
                        return model
                    } catch {
                        print("Error fetching or decoding data from \(link): \(error)")
                        return nil
                    }
                }
            }
            return try await group.reduce(into: [T?]()) { models, model in
                models.append(model)
            }
        }
        return results
    }
}
