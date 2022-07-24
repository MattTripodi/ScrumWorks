//
//  ScrumWorksApp.swift
//  ScrumWorks
//
//  Created by Matthew Tripodi on 7/16/22.
//

import SwiftUI

@main
struct ScrumWorksApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
