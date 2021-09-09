//
//  Standing.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import Foundation
import SwiftUI

struct Standing: Decodable, Identifiable {
    var id:UUID?
    var season:Int?
    var seasonType:Int?
    var teamId:Int?
    var key:String?
    var city:String?
    var name:String?
    var conference:String?
    var division:String?
    var wins:Int?
    var losses:Int?
    var percentage:Decimal?
    var conferenceWins:Int?
    var conferenceLosses:Int?
    var divisionWins:Int?
    var divisionLosses:Int?
    var homeWins:Int?
    var homeLosses:Int?
    var awayWins:Int?
    var awayLosses:Int?
    var lastTenWins:Int?
    var lastTenLosses:Int?
    var pointsPerGameFor:Decimal?
    var pointsPerGameAgainst:Decimal?
    var streak:Int?
    var gamesBack:Decimal?
    var streakDescription:String?
    var globalTeamId:Int?
    var conferenceRank:Int?
    var divisionRank:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case season = "Season"
        case seasonType = "SeasonType"
        case teamId = "TeamID"
        case key = "Key"
        case city = "City"
        case name = "Name"
        case conference = "Conference"
        case division = "Division"
        case wins = "Wins"
        case losses = "Losses"
        case percentage = "Percentage"
        case conferenceWins = "ConferenceWins"
        case conferenceLosses = "ConferenceLosses"
        case divisionWins = "DivisionWins"
        case divisionLosses = "DivisionLosses"
        case homeWins = "HomeWins"
        case homeLosses = "HomeLosses"
        case awayWins = "AwayWins"
        case awayLosses = "AwayLosses"
        case lastTenWins = "LastTenWins"
        case lastTenLosses = "LastTenLosses"
        case pointsPerGameFor = "PointsPerGameFor"
        case pointsPerGameAgainst = "PointsPerGameAgainst"
        case streak = "Streak"
        case gamesBack = "GamesBack"
        case streakDescription = "StreakDescription"
        case globalTeamId = "GlobalTeamID"
        case conferenceRank = "ConferenceRank"
        case divisionRank = "DivisionRank"
    }
}
