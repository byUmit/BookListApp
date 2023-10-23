//
//  BookListView.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 22.10.2023.
//

import ComposableArchitecture
import SwiftUI

struct BookListView: View {
    let store: StoreOf<BookListReducer>

    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                List {
                    if let books = viewStore.books {
                        ForEach(books, id: \.isbn) { book in
                            NavigationLink(state: BookDetailReducer.State(book: book)) {
                                Text(book.name)
                            }.buttonStyle(.borderless)
                        }
                    } else {
                        Text("Book list is empty, refresh the page.")
                    }
                }
                .navigationTitle("Books")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.fetchBooks)
                        } label: {
                            Text("refresh")
                        }
                    }
                })
            }
        } destination: { store in
            BookDetailView(store: store)
        }
    }
}

#Preview {
    BookListView(store: Store(initialState: BookListReducer.State(), reducer: {
        BookListReducer()
    }))
}
