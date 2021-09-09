//
//  GamesFavoriteView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI

struct GamesFavoriteView: View {
    
    @EnvironmentObject var model:GameModel
    
    var teams:[String:Team]
    
    var body: some View {
        
        // If there is a favorite team...
        if model.favoriteTeam != nil {
            
            // If the away or home team is the favorite team...
            if teams[Constants.awayKey]!.name == model.teams[model.favoriteTeam!].name || teams[Constants.homeKey]!.name == model.teams[model.favoriteTeam!].name {
                
                // Show a star and the team city/name
                HStack(spacing: 5) {
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("\(model.teams[model.favoriteTeam!].city ?? "") \(model.teams[model.favoriteTeam!].name ?? "")")
                }
                .padding(.top, 2)
            }
        }
    }
}
