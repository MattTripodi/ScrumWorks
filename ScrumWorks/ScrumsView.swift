//
//  ScrumsView.swift
//  ScrumWorks
//
//  Created by Matthew Tripodi on 7/18/22.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    //The isPresentingNewScrumView property controls the presentation of the edit view to create a new scrum
    @State private var isPresentingNewScrumView = false
    //newScrumData is the source of truth for all the changes the user makes to the new scrum
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button(action: {
                isPresentingNewScrumView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationView {
                DetailEditView(data: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                //The properties of newScrumData are bound to the controls of DetailEditView and have the current information that the user set. The scrums array contains elements of DailyScrum
                                let newScrum = DailyScrum(data: newScrumData)
                                //The scrums array is a binding, so updating the array in this view updates the source of truth contained in the app.
                                scrums.append(newScrum)
                                isPresentingNewScrumView = false
                                //Resetting newScrumData ensures previous modifications aren’t visible if the user taps the Add button again.
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            //A scene in the inactive phase no longer receives events and may be unavailable to the user.
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
