//
//  StatsTabView.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/5/21.
//

import SwiftUI

struct StatsTabView: View {
    var body: some View {
        
        // Create a tab view
        TabView {
            
            // Tab 1
            GamesView()
                .tabItem {
                    VStack {
                        Image(systemName: "sportscourt")
                        Text("Games")
                    }
                }
                .tag(0)
            
            // Tab 2
            StandingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.number")
                        Text("Standings")
                    }
                }
                .tag(1)
            
            // Tab 3
            FavoriteView()
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("Favorites")
                    }
                }
                .tag(2)
        }
    }
}

struct StatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        StatsTabView()
    }
}
