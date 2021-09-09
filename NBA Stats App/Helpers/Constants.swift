//
//  Constants.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/3/21.
//

import Foundation
import SwiftUI

struct Constants {
    
    static var apiKey = "YOUR_API_KEY_HERE"
    static var apiScoresUrl = "https://fly.sportsdata.io/v3/nba/scores/json/GamesByDate/"
    static var apiCurrentSeasonUrl = "https://fly.sportsdata.io/v3/nba/scores/json/CurrentSeason"
    static var apiGamesInProgressUrl = "https://fly.sportsdata.io/v3/nba/scores/json/AreAnyGamesInProgress"
    static var apiTeamsUrl = "https://fly.sportsdata.io/v3/nba/scores/json/AllTeams"
    static var apiStandingsUrl = "https://fly.sportsdata.io/v3/nba/scores/json/Standings/"
    static var apiPlayersUrl = "https://api.sportsdata.io/v3/nba/stats/json/Players/"
    
    static var selectYesterday = "yesterday"
    static var selectToday = "today"
    static var selectTomorrow = "tomorrow"
    
    static var awayKey = "Away"
    static var homeKey = "Home"
    
    static var scheduleStatus = "Scheduled"
    
    static var selectEasternConference = 0
    static var selectWesternConference = 1
    
    static var goldGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 191/255, green: 149/255, blue: 63/255), Color(red: 252/255, green: 246/255, blue: 86/255), Color(red: 179/255, green: 135/255, blue: 40/255), Color(red: 251/255, green: 245/255, blue: 183/255), Color(red: 170/255, green: 119/255, blue: 28/255)]), startPoint: .leading, endPoint: .trailing)
}
