//
//  ScrumWorksApp.swift
//  ScrumWorks
//
//  Created by Matthew Tripodi on 7/16/22.
//

import SwiftUI

@main
struct ScrumWorksApp: App {
    //The @StateObject property wrapper creates a single instance of an observable object for each instance of the structure that declares it.
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    //Task creates a new asynchronous context that will be used to call ScrumStore.save().
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            fatalError("Error saving scrums.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    fatalError("Error loading scrums.")
                }
            }
        }
    }
}
