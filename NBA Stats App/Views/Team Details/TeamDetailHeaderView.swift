//
//  TeamDetailHeader.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/22/21.
//

import SwiftUI
import SVGKit

struct TeamDetailHeaderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var model:GameModel
    
    var team:Team
    
    var body: some View {
        HStack {
            
            
            // Team Logo
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
                        .padding(.trailing, 10)
                } else {
                    Image(uiImage: svgImage!.uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(color: .white.opacity(0.7), radius: 5)
                        .padding(.trailing, 10)
                }
            }
            
            // Team Name/City
            VStack(alignment: .leading) {
                Text(team.city ?? "")
                    .font(.largeTitle)
                    .bold()
                Text(team.name ?? "")
                    .font(.largeTitle)
                    .bold()
            }
            .padding(.trailing, 15)
            
            
            // If there is a favorite team...
            if model.favoriteTeam != nil {
                
                // If the away or home team is the favorite team...
                if team.name == model.teams[model.favoriteTeam!].name {
                    
                    Spacer()
                    
                    // Show a star
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .scaledToFill()
                        .foregroundColor(.yellow)
                        .padding(.top, 2)
                }
            }
        }
    }
}
