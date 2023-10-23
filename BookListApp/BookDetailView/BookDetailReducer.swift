//
//  BookDetailReducer.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 23.10.2023.
//

import ComposableArchitecture
import Foundation

class BookDetailReducer: Reducer {
    @Dependency(\.bookClient) var bookClient

    struct State: Equatable {
        var book: Book
        var characters: [Character]?
        var isLoading: Bool = false
    }

    enum Action {
        case fetchCharacters
        case characterFetched([Character]?)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchCharacters:
            let characterURLs = state.book.characters
            state.isLoading = true
            return .run { send in
                let characters = try? await self.bookClient.fetchCharacters(characterURLs)
                await send(.characterFetched(characters))
            }
        case let .characterFetched(characters):
            state.isLoading = false
            state.characters = characters
            return .none
        }
    }
}
