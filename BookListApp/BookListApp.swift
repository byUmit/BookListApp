//
//  BookListApp.swift
//  BookListApp
//
//  Created by Bozkurt, Umit on 22.10.2023.
//
import ComposableArchitecture
import SwiftUI

@main
struct BookListApp: App {
    private static let store = Store(initialState: BookListReducer.State(), reducer: {
        BookListReducer()
    })

    var body: some Scene {
        WindowGroup {
            BookListView(store: BookListApp.store)
        }
    }
}
