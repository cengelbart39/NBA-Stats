//
//  Game.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/3/21.
//

import Foundation
import SwiftUI

class Game: Decodable, Identifiable, ObservableObject {
    
    @Published var startingDateTime:String?
    @Published var isFavoriteGame = false
    @Published var gradient:LinearGradient?
    
    var id:UUID?
    var gameId:Int?
    var season:Int?
    var seasonType:Int?
    var status:String?
    var day:String?
    var dateTime:String?
    var awayTeam:String?
    var homeTeam:String?
    var awayTeamId:Int?
    var homeTeamId:Int?
    var stadiumId:Int?
    var channel:String?
    var attendance:Int?
    var awayTeamScore:Int?
    var homeTeamScore:Int?
    var updated:String?
    var quarter:String?
    var timeRemainingMinutes:Int?
    var timeRemainingSeconds:Int?
    var pointSpread:Decimal?
    var overUnder:Decimal?
    var awayTeamMoneyLine:Int?
    var homeTeamMoneyLine:Int?
    var globalGameId:Int?
    var globalAwayTeamId:Int?
    var globalHomeTeamId:Int?
    var pointSpreadAwayTeamMoneyLine:Int?
    var pointSpreadHomeTeamMoneyLine:Int?
    var lastPlay:String?
    var isClosed:Bool?
    var quarters:[Quarter]?
    var gameEndDateTime:String?
    var homeRotationNumber:Int?
    var awayRotationNumber:Int?
    var neturalVenue:Bool?
    var overPayout:Int?
    var underPayout:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case gameId = "GameID"
        case season = "Season"
        case seasonType = "SeasonType"
        case status = "Status"
        case day = "Day"
        case dateTime = "DateTime"
        case awayTeam = "AwayTeam"
        case homeTeam = "HomeTeam"
        case awayTeamId = "AwayTeamID"
        case homeTeamId = "HomeTeamID"
        case stadiumId = "StadiumID"
        case channel = "Channel"
        case attendance = "Attendance"
        case awayTeamScore = "AwayTeamScore"
        case homeTeamScore = "HomeTeamScore"
        case updated = "Updated"
        case quarter = "Quarter"
        case timeRemainingMinutes = "TimeRemainingMinutes"
        case timeRemainingSeconds = "TimeRemainingSeconds"
        case pointSpread = "PointSpread"
        case overUnder = "OverUnder"
        case awayTeamMoneyLine = "AwayTeamMoneyLine"
        case homeTeamMoneyLine = "HomeTeamMoneyLine"
        case globalGameId = "GlobalGameID"
        case globalAwayTeamId = "GlobalAwayTeamID"
        case globalHomeTeamId = "GlobalHomeTeamID"
        case pointSpreadAwayTeamMoneyLine = "PointSpreadAwayTeamMoneyLine"
        case pointSpreadHomeTeamMoneyLine = "PointSpreadHomeTeamMoneyLine"
        case lastPlay = "LastPlay"
        case isClosed = "IsClosed"
        case quarters = "Quarters"
        case gameEndDateTime = "GameEndDateTime"
        case homeRotationNumber = "HomeRotationNumber"
        case awayRotationNumber = "AwayRotationNumber"
        case neturalVenue = "NeutralVenue"
        case overPayout = "OverPayout"
        case underPayout = "UnderPayout"
    }
    
    func getStartingTime(game: Game, returnFormat:String) {
        
        // If there is a datetime
        if self.dateTime != nil {
            
            var dT = self.dateTime!
            
            // Remove the T
            dT.remove(at: dT.firstIndex(of: "T")!)
            
            // Create a DateFormatter
            let dateFormatter = DateFormatter()
            
            // Set the format
            dateFormatter.dateFormat = "YYYY-MM-ddHH:mm:ss"
            
            // Create a date with the format
            let date = dateFormatter.date(from: dT)
            
            // Format settings
            dateFormatter.dateFormat = returnFormat
            dateFormatter.timeStyle = .short
            
            // Convert date to string
            self.startingDateTime = dateFormatter.string(from: date!)
        }
    }
    
    func isFavoriteGame(teams:[Team], favoriteTeam:Int?) {
        
        // If there is a favorite team...
        if favoriteTeam != nil {
            
            // If the favorite team is the away or home team...
            if self.awayTeamId == teams[favoriteTeam!].teamId || self.homeTeamId == teams[favoriteTeam!].teamId {
                
                // Set to true
                self.isFavoriteGame = true
            } else {
                // Set to false
                self.isFavoriteGame = false
            }
        } else {
            // Set to false
            self.isFavoriteGame = false
        }
    }
    
    func getGradient(game: Game, teams:[String:Team]) {
        
        // if there is a favorite game...
        if isFavoriteGame {
            // use the gold gradient
            self.gradient = Constants.goldGradient
            
        // If there are two teams...
        } else if teams.count == 2 {
            // Get primary colors
            let awayColor = Team.hexCodeToColor(hexCode: teams[Constants.awayKey]!.primaryColor!)
            let homeColor = Team.hexCodeToColor(hexCode: teams[Constants.homeKey]!.primaryColor!)
                
            // Create a gradient
            let gradient = Gradient(colors: [Color(awayColor), Color(homeColor)])
                
            // Create a linear gradient
            self.gradient = LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
        }
    }
}

struct Quarter: Decodable {
    var quarterId:Int?
    var gameId:Int?
    var number:Int?
    var name:String?
    var awayScore:Int?
    var homeScore:Int?
    
    enum CodingKeys: String, CodingKey {
        case quarterId = "QuarterID"
        case gameId = "GameID"
        case number = "Number"
        case name = "Name"
        case awayScore = "AwayScore"
        case homeScore = "HomeScore"
    }
}
