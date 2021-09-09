//
//  GamesCardView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/5/21.
//

import SwiftUI

struct GamesCardView: View {
    
    @EnvironmentObject var model:GameModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var selectedDay:String
    var game:Game
    
    var body: some View {
        // Get teams for game
        let teams = model.getTeamsForGame(game: game)
        
        ScrollView {
            
            LazyVStack {
                
                ZStack {
                    
                    // Card
                    if colorScheme == .light {
                        RectangleCard(color: .white, gradient: game.gradient)
                            .frame(height: 215)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                    } else {
                        RectangleCard(color: Color(.systemGray6), gradient: game.gradient)
                            .frame(height: 215)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                            .shadow(color: .white.opacity(0.25), radius: 5)
                    }
                    
                    VStack {
                        
                        HStack {
                            
                            Spacer()
                            
                            // Away Team
                            GamesTeamInfo(selectedDay: selectedDay, game: game, team: teams[Constants.awayKey]!)
                            
                            Spacer()
                            
                            // VS Text
                            Text("VS")
                                .bold()
                                .font(.title)
                            
                            Spacer()
                            
                            // Home Team
                            GamesTeamInfo(selectedDay: selectedDay, game: game, team: teams[Constants.homeKey]!)
                            
                            
                            Spacer()
                        }
                        
                        // Display Status
                        GamesDisplayStatus(game: game)
                    }
                }
                .padding()
            }
        }
    }
}
