//
//  TeamDetailStatsView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/22/21.
//

import SwiftUI

struct TeamConferenceStatsView: View {
    
    // Create a number formatter for two decimal points (1.23)
    let formatter:NumberFormatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var standing:Standing
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Conference")
                    Text("Wins")
                        .padding(.bottom, 10)
                    
                    Text(String(standing.conferenceWins ?? 0))
                        .bold()
                        .font(.title2)
                    
                }
                
                Spacer()
                
                VStack {
                    
                    Text("Confernece")
                    Text("Losses")
                        .padding(.bottom, 10)
                    Text(String(standing.conferenceLosses ?? 0))
                        .bold()
                        .font(.title2)
                    
                }

                Spacer()
                
                VStack {
                    Text("Conference")
                    Text("Win Rate")
                        .padding(.bottom, 10)
                    
                    let totalGames = Double((standing.conferenceWins ?? 0) + (standing.conferenceLosses ?? 0))
                    let percentage = (Double(standing.conferenceWins ?? 0) / totalGames) * 100.0
                    
                    Text("\(formatter.string(from: NSNumber(value: percentage)) ?? "")%")
                        .bold()
                        .font(.title2)
                    
                }
                
                Spacer()
            }
        }
    }
}
