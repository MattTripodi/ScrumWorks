//
//  MeetingTimerView.swift
//  ScrumWorks
//
//  Created by Matthew Tripodi on 7/26/22.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    
    //Computed property named currentSpeaker that returns the name of the current speaker. The current speaker is the first person on the list who hasn’t spoken. If there isn’t a current speaker, the expression returns “Someone.”
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text("Placeholder")
                        .font(.title)
                    Text("is speaking")
                }
                //This modifier makes VoiceOver read the two text views as one sentence.
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    //if statement that checks whether the speaker is finished and uses optional binding to find the index of the speaker.
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            //Rotating the arc moves the 0-degree angle to the 12 o’clock position.
                            .rotation(Angle(degrees: -90))
                            //The stroke modifier traces a line along the path of the shape.
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers, theme: .yellow)
    }
}
