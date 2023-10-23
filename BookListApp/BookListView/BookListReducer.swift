//
//  BookListReducer.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 22.10.2023.
//
import ComposableArchitecture
import Foundation

class BookListReducer: Reducer {
    struct State: Equatable {
        var path = StackState<BookDetailReducer.State>()
        var books: [Book]?
    }

    enum Action {
        case fetchBooks
        case booksFetched([Book]?)
        case path(StackAction<BookDetailReducer.State, BookDetailReducer.Action>)
    }
    
    var body: some ReducerOf<BookListReducer> {
        Reduce { state, action in
            switch action {
            case .fetchBooks:
                return .run { send in
                    let bookListUrl = "https://anapioficeandfire.com/api/books"
                    let (data, _) = try await URLSession.shared.data(from: URL(string: bookListUrl)!)
                    let books = try? JSONDecoder().decode([Book].self, from: data)
                    await send(.booksFetched(books))
                }
            case let .booksFetched(books):
                state.books = books
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            BookDetailReducer()
        }
    }
}
