//
//  LaunchView.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/3/21.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model:GameModel
    
    var body: some View {
        // If team and game data was gathered...
        if model.haveTodayGames && model.haveYesterdayGames && model.haveTomorrowGames && model.teams.count > 0 {
            // Show the rest of tab views
            StatsTabView()
        } else {
            // Show a loading circle
            ProgressView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
