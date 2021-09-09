//
//  StandingsRowView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI

struct StandingsRowView: View {
    
    @EnvironmentObject var model:GameModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var conference:Standing
    var index:Int
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            // If the team has the highest standing...
            if index == 0 {
                
                // Create a card with a golden background
                RectangleCard(color: Color(red: 255/255, green: 215/255, blue: 0))
                    .frame(height: 50)
                
                // If the team has the second highest standing...
            } else if index == 1 {
                
                // Create a card with a silver background
                RectangleCard(color: Color(red: 192/255, green: 192/255, blue: 192/255))
                    .frame(height: 50)
                
                // If the team has the third highest standing...
            } else if index == 2 {
                
                // Create a card with a bronze background
                RectangleCard(color: Color(red: 176/255, green: 141/255, blue: 87/255))
                    .frame(height: 50)
                
                // If the team has any other standing
            } else {
                
                // If light mode...
                if colorScheme == .light {
                    // Create a card with a white background
                    RectangleCard(color: .white)
                        .frame(height: 50)
                    
                    // If dark mode...
                } else {
                    // Create a card with a black background
                    RectangleCard(color: Color(.systemGray6))
                        .frame(height: 50)
                }
            }
            
            HStack(spacing: 15) {
                
                // Team Placement
                if colorScheme == .light {
                    Text(String(index+1))
                        .bold()
                } else {
                    Text(String(index+1))
                        .bold()
                        .foregroundColor(index >= 0 && index <= 2 ? .black : .white)
                }
                
                // Team City/Name
                if colorScheme == .light {
                    Text("\(conference.city ?? "") \(conference.name ?? "")")
                } else {
                    Text("\(conference.city ?? "") \(conference.name ?? "")")
                        .foregroundColor(index >= 0 && index <= 2 ? .black : .white)
                }
                
                // If there is a favorite team...
                if model.favoriteTeam != nil {
                    
                    // If the favorite team is in this conference...
                    if model.teams[model.favoriteTeam!].name == conference.name {
                        
                        // Display a star
                        if colorScheme == .light {
                            Image(systemName: "star.fill")
                                .padding(.leading, -10)
                        } else {
                            Image(systemName: "star.fill")
                                .padding(.leading, -10)
                                .foregroundColor(index >= 0 && index <= 2 ? .black : .white)
                        }
                    }
                }
                
                Spacer()
                
                // Show Win-Lost Ratio
                if colorScheme == .light {
                    Text("\(conference.wins ?? 0) - \(conference.losses ?? 0)")
                } else {
                    Text("\(conference.wins ?? 0) - \(conference.losses ?? 0)")
                        .foregroundColor(index >= 0 && index <= 2 ? .black : .white)
                }
            }
            .padding()
        }
    }
}
