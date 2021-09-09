//
//  TeamDetailView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/22/21.
//

import SwiftUI
import SVGKit

struct TeamDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var model:GameModel
    
    var standing:Standing
    
    var body: some View {
        
        let team = model.getTeamFromStanding(standing: standing)
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 45) {
                
                // Team Logo, Name, and Favorite Status
                TeamDetailHeaderView(team: team)
                    .padding(.top, -50)
                    .padding(.bottom, -20)
                
                // Conference Stats
                if !(standing.conferenceWins ?? 0 == 0 && standing.conferenceLosses ?? 0 == 0) {
                    ZStack {
                        
                        RectangleCard(color: colorScheme == .light ? .white : Color(.systemGray6))
                            .frame(height: 125)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                        
                        TeamConferenceStatsView(standing: standing)
                        
                    }
                }
                
                // Division Stats
                if !(standing.divisionWins ?? 0 == 0 && standing.divisionLosses ?? 0 == 0) {
                    
                    ZStack {
                        
                        RectangleCard(color: colorScheme == .light ? .white : Color(.systemGray6))
                            .frame(height: 125)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                        
                        TeamDivisionStatsView(standing: standing)
                    }
                }
                
                // Home Stats
                if !(standing.homeWins ?? 0 == 0 && standing.homeLosses ?? 0 == 0) {
                    ZStack {
                        
                        RectangleCard(color: colorScheme == .light ? .white : Color(.systemGray6))
                            .frame(height: 125)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                        
                        TeamHomeStatsView(standing: standing)
                    }
                }
                
                // Away Stats
                if !(standing.awayWins ?? 0 == 0 && standing.awayLosses ?? 0 == 0) {
                    ZStack {
                        
                        RectangleCard(color: colorScheme == .light ? .white : Color(.systemGray6))
                            .frame(height: 125)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                        
                        TeamAwayStatsView(standing: standing)
                    }
                }
                
                if team.players != nil {
                    ZStack {
                        
                        RectangleCard(color: colorScheme == .light ? .white : Color(.systemGray6))
                            .frame(height: 400)
                            .padding(.bottom, -15)
                            .padding(.top, -10)
                        
                        VStack {
                            
                            Text("Players")
                                .bold()
                                .font(.title2)
                            
                            TeamPlayersView(players: team.players!)
                        }
                        
                    }
                }
            }
            .padding()
        }
        
    }
}
