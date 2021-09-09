//
//  TeamAwayStatsView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/23/21.
//

import SwiftUI

struct TeamAwayStatsView: View {
    
    // Create a number formatter for two decimal points (1.23)
    let formatter:NumberFormatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var standing:Standing
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            VStack {
                
                Text("Away")
                Text("Wins")
                    .padding(.bottom, 10)
                
                Text(String(standing.awayWins ?? 0))
                    .bold()
                    .font(.title2)
            }
            
            Spacer()
            
            VStack {
                
                Text("Away")
                Text("Losses")
                    .padding(.bottom, 10)
                
                Text(String(standing.awayLosses ?? 0))
                    .bold()
                    .font(.title2)
            }
            
            Spacer()
            
            VStack {
                
                Text("Away")
                Text("Win Rate")
                    .padding(.bottom, 10)
                
                let totalGames = Double((standing.awayWins ?? 0) + (standing.awayLosses ?? 0))
                let percentage = (Double(standing.awayWins ?? 0) / totalGames) * 100.0
                
                Text("\(formatter.string(from: NSNumber(value: percentage)) ?? "")%")
                    .bold()
                    .font(.title2)
            }
            
            Spacer()
            
        }
        
    }
}
