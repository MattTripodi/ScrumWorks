//
//  ScrumStore.swift
//  ScrumWorks
//
//  Created by Matthew Tripodi on 7/25/22.
//

import Foundation
import SwiftUI

//ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
class ScrumStore: ObservableObject {
    //An ObservableObject includes an objectWillChange publisher that emits when one of its @Published properties is about to change. Any view observing an instance of ScrumStore will render again when the scrums value changes.
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        //Use the shared instance of the FileManager class to get the location of the Documents directory for the current user.
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
}
