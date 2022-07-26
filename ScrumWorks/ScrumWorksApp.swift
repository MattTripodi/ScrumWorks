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
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear() {
                ScrumStore.load { result in
                    //Switch statement to update the store’s scrums array with the decoded data or halt execution if load(completion:) returns an error.
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let scrums):
                        store.scrums = scrums
                    }
                }
            }
        }
    }
}
