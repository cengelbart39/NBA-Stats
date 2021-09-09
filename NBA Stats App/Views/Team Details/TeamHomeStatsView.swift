//
//  TeamHomeStatsView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/22/21.
//

import SwiftUI

struct TeamHomeStatsView: View {
    
    // Create a number formatter for two decimal points (1.23)
    let formatter:NumberFormatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var standing:Standing
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Home")
                    Text("Wins")
                        .padding(.bottom, 10)
                    
                    Text(String(standing.homeWins ?? 0))
                        .bold()
                        .font(.title2)
                }
                
                Spacer()
                
                VStack {
                    
                    Text("Home")
                    Text("Losses")
                        .padding(.bottom, 10)
                    
                    Text(String(standing.homeLosses ?? 0))
                        .bold()
                        .font(.title2)
                }
                
                Spacer()
                
                VStack {
                    
                    Text("Home")
                    Text("Win Rate")
                        .padding(.bottom, 10)
                    
                    let totalGames = Double((standing.homeWins ?? 0) + (standing.homeLosses ?? 0))
                    let percentage = (Double(standing.homeWins ?? 0) / totalGames) * 100.0
                    
                    Text("\(formatter.string(from: NSNumber(value: percentage)) ?? "")%")
                        .bold()
                        .font(.title2)
                }
                
                Spacer()
                
            }
            
            
        }  
    }
}
