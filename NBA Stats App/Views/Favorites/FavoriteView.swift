//
//  FavoriteView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var model:GameModel
    
    @State var favoriteTeam = 0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Title
            Text("Favorite Team")
                .font(.largeTitle)
                .bold()
            
            VStack {
                
                Spacer()
                
                // Picker
                Picker("Pick Your Favorite Team", selection: $favoriteTeam) {
                    ForEach(0..<model.teams.count) { index in
                        Text("\(model.teams[index].city ?? "") \(model.teams[index].name ?? "")")
                            .tag(index)
                    }
                }
                .onChange(of: favoriteTeam) { value in
                    
                    // If yesterday games array exists...
                    if model.yesterdayGames != nil {
                        
                        // If it contains values...
                        if model.yesterdayGames!.count > 0 {
                            
                            // Reset favorite status for games
                            for game in model.yesterdayGames! {
                                game.isFavoriteGame = false
                            }
                        }
                    }
                    
                    // If today games array exists...
                    if model.todayGames != nil {
                        
                        // If it contains values...
                        if model.todayGames!.count > 0 {
                            
                            // Reset favorite status for games
                            for game in model.todayGames! {
                                game.isFavoriteGame = false
                            }
                        }
                    }
                    
                    // If tomorrow games array exists...
                    if model.tomorrowGames != nil {
                        
                        // If it contains values...
                        if model.tomorrowGames!.count > 0 {
                            
                            // Reset favorite status for games
                            for game in model.tomorrowGames! {
                                game.isFavoriteGame = false
                            }
                        }
                    }
                    
                    // Update favorite team to selected team
                    model.favoriteTeam = favoriteTeam
                    
                    // Check if any games are favorited now
                    if model.yesterdayGames != nil {
                        for game in model.yesterdayGames! {
                            game.isFavoriteGame(teams: model.teams, favoriteTeam: favoriteTeam)
                        }
                    }
                    
                    if model.todayGames != nil {
                        for game in model.todayGames! {
                            game.isFavoriteGame(teams: model.teams, favoriteTeam: favoriteTeam)
                        }
                    }
                    
                    if model.tomorrowGames != nil {
                        for game in model.tomorrowGames! {
                            game.isFavoriteGame(teams: model.teams, favoriteTeam: favoriteTeam)
                        }
                    }
                    
                    // Reorder the games based on favorited team
                    model.favoriteReorder()
                }
                
                Spacer()
            }
        }
        .padding()
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
