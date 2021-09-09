//
//  TeamDivisionStatsView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/22/21.
//

import SwiftUI

struct TeamDivisionStatsView: View {
    
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
                    
                    Text("Division")
                    Text("Wins")
                        .padding(.bottom, 10)
                    
                    Text(String(standing.divisionWins ?? 0))
                        .bold()
                        .font(.title2)
                    
                }
                
                Spacer()
                
                VStack {
                    
                    Text("Divison")
                    Text("Losses")
                        .padding(.bottom, 10)
                    Text(String(standing.divisionLosses ?? 0))
                        .bold()
                        .font(.title2)
                    
                }

                Spacer()
                
                VStack {
                    Text("Division")
                    Text("Win Rate")
                        .padding(.bottom, 10)
                    
                    let totalGames = Double((standing.divisionWins ?? 0) + (standing.divisionLosses ?? 0))
                    let percentage = (Double(standing.divisionWins ?? 0) / totalGames) * 100.0
                    
                    Text("\(formatter.string(from: NSNumber(value: percentage)) ?? "")%")
                        .bold()
                        .font(.title2)
                    
                }
                
                Spacer()
            }
            
        }
        
    }
}
