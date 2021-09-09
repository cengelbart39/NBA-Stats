//
//  Player.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/23/21.
//

import Foundation

class Player: Decodable, Identifiable {
    var id:UUID?
    var playerId:Int?
    var sportsDataId:String?
    var status:String?
    var teamId:Int?
    var team:String?
    var jersey:Int?
    var positionCategory:String?
    var position:String?
    var firstName:String?
    var lastName:String?
    var height:Int?
    var weight:Int?
    var birthDate:String?
    var birthCity:String?
    var birthState:String?
    var birthCountry:String?
    var highSchool:String?
    var college:String?
    var salary:Int?
    var photoUrl:String?
    var experience:Int?
    var sportRadarPlayerId:String?
    var rotoworldPlayerId:Int?
    var rotoWirePlayerId:Int?
    var fantasyAlarmPlayerId:Int?
    var statsPlayerId:Int?
    var sportsDirectPlayerId:Int?
    var xmlTeamPlayerId:Int?
    var injuryStatus:String?
    var injuryBodyPart:String?
    var injuryStartDate:String?
    var injryNotes:String?
    var fanDuelPlayerId:Int?
    var draftKingsPlayerId:Int?
    var yahooPlayerId:Int?
    var fanDuelName:String?
    var draftKingsName:String?
    var yahooName:String?
    var depthChartPosition:String?
    var depthChartOrder:Int?
    var globalTeamId:Int?
    var fantasyDraftName:String?
    var fantasyDraftPlayerId:Int?
    var usaTodayPlayerId:Int?
    var usaTodayHeadshotUrl:String?
    var usaTodayHeadshotNoBackgroundUrl:String?
    var usaTodayHeadshotUpdated:String?
    var usaTodayHradshotNoBackgroundUpdated:String?
    var nbaDotComePlayerId:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case playerId = "PlayerID"
        case sportsDataId = "SportsDataID"
        case status = "Status"
        case teamId = "TeamID"
        case team = "Team"
        case jersey = "Jersey"
        case positionCategory = "PositionCategory"
        case position = "Position"
        case firstName = "FirstName"
        case lastName = "LastName"
        case height = "Height"
        case weight = "Weight"
        case birthDate = "BirthDate"
        case birthCity = "BirthCity"
        case birthState = "BirthState"
        case birthCountry = "BirthCountry"
        case highSchool = "HighSchool"
        case college = "College"
        case salary = "Salary"
        case photoUrl = "PhotoUrl"
        case experience = "Experience"
        case sportRadarPlayerId = "SportRadarPlayerID"
        case rotoworldPlayerId = "RotoworldPlayerID"
        case rotoWirePlayerId = "RotoWirePlayerID"
        case fantasyAlarmPlayerId = "FantasyAlarmPlayerID"
        case statsPlayerId = "StatsPlayerID"
        case sportsDirectPlayerId = "SportsDirectPlayerID"
        case xmlTeamPlayerId = "XmlTeamPlayerID"
        case injuryStatus = "InjuryStatus"
        case injuryBodyPart = "InjuryBodyPart"
        case injuryStartDate = "InjuryStartDate"
        case injryNotes = "InjuryNotes"
        case fanDuelPlayerId = "FanDuelPlayerID"
        case draftKingsPlayerId = "DraftKingsPlayerID"
        case yahooPlayerId = "YahooPlayerID"
        case fanDuelName = "FanDuelName"
        case draftKingsName = "DraftKingsName"
        case yahooName = "YahooName"
        case depthChartPosition = "DepthChartPosition"
        case depthChartOrder = "DepthChartOrder"
        case globalTeamId = "GlobalTeamID"
        case fantasyDraftName = "FantasyDraftName"
        case fantasyDraftPlayerId = "FantasyDraftPlayerID"
        case usaTodayPlayerId = "UsaTodayPlayerID"
        case usaTodayHeadshotUrl = "UsaTodayHeadshotUrl"
        case usaTodayHeadshotNoBackgroundUrl = "UsaTodayHeadshotNoBackgroundUrl"
        case usaTodayHeadshotUpdated = "UsaTodayHeadshotUpdated"
        case usaTodayHradshotNoBackgroundUpdated = "UsaTodayHeadshotNoBackgroundUpdated"
        case nbaDotComePlayerId = "NbaDotComPlayerID"
    }
}
