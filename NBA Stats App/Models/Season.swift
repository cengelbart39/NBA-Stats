//
//  Season.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/4/21.
//

import Foundation

struct Season: Decodable {
    var season:Int?
    var startYear:Int?
    var endYear:Int?
    var description:String?
    var regularSeasonStartDate:String?
    var postSeasonStartDate:String?
    var seasonType:String?
    var apiSeason:String?
    
    enum CodingKeys: String, CodingKey {
        case season = "Season"
        case startYear = "StartYear"
        case endYear = "EndYear"
        case description = "Description"
        case regularSeasonStartDate = "RegularSeasonStartDate"
        case postSeasonStartDate = "PostSeasonStartDate"
        case seasonType = "SeasonType"
        case apiSeason = "ApiSeason"
    }
}
