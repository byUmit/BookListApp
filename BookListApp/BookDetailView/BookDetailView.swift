//
//  BookDetailView.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 23.10.2023.
//

import ComposableArchitecture
import SwiftUI

struct BookDetailView: View {
    let store: StoreOf<BookDetailReducer>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                if viewStore.isLoading {
                    ProgressView()
                } else if let characters = viewStore.characters  {
                    ForEach(characters, id: \.url) { character in
                        Text(character.name)
                    }
                } else {
                    Text("Something went wrong")
                }
            }
            .navigationBarTitle(Text(viewStore.book.name))
            .onAppear {
                viewStore.send(.fetchCharacters)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(store: Store(initialState: BookDetailReducer.State(book: Book.mock), reducer: {
            BookDetailReducer()
        }))
    }
}
