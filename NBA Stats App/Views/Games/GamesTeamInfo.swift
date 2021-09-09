//
//  GamesTeamInfo.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI
import SVGKit

struct GamesTeamInfo: View {
    
    @EnvironmentObject var model:GameModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var selectedDay:String
    var game:Game
    var team:Team
    
    var body: some View {
        VStack {
            
            // If there is image data...
            if team.imageData != nil {
                // Create SVGKImage
                let svgImage = SVGKImage(data: team.imageData)
                
                // Create image
                if colorScheme == .light {
                    Image(uiImage: svgImage!.uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } else {
                    Image(uiImage: svgImage!.uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(color: .white.opacity(0.2), radius: 5)
                }
            }
            
            // If there were gamers yesterday or
            // there are games today and there are ongoing games
            if selectedDay == Constants.selectYesterday || (selectedDay == Constants.selectToday && model.areOnGoingGames) {
                
                // If the away team has a score and the away team is the passed in team
                if game.awayTeamScore != nil && game.awayTeamId == team.teamId {
                    
                    // If the away team score is greater than the home team score
                    if game.awayTeamScore ?? 0 > game.homeTeamScore ?? 0 {
                        
                        // Create a bold text element
                        Text(String(game.awayTeamScore!))
                            .bold()
                            .font(.title2)
                            .padding(.bottom, 1)
                    } else {
                        
                        // Create a text element
                        Text(String(game.awayTeamScore!))
                            .font(.title2)
                            .padding(.bottom, 1)
                    }
                }
                
                // If the home team has a score and is the passed in team
                if game.homeTeamScore != nil && game.homeTeamId == team.teamId {
                    
                    // If the home team score is greater than the away team score
                    if game.homeTeamScore ?? 0 > game.awayTeamScore ?? 0 {
                        
                        // Show a bold text element
                        Text(String(game.homeTeamScore!))
                            .bold()
                            .font(.title2)
                            .padding(.bottom, 1)
                        
                    } else {
                        
                        // Shopw a text element
                        Text(String(game.homeTeamScore!))
                            .font(.title2)
                            .padding(.bottom, 1)
                    }
                }
            }
        }
    }
}
