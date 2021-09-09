//
//  Team.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/3/21.
//

import Foundation
import SwiftUI
import SVGKit

class Team: Decodable, Identifiable, ObservableObject {
    
    @Published var imageData:Data?
    @Published var isFavorite = false
    
    var id:UUID?
    var teamId:Int?
    var key:String?
    var active:Bool?
    var city:String?
    var name:String?
    var leagueId:Int?
    var stadiumId:Int?
    var conference:String?
    var division:String?
    var primaryColor:String?
    var secondaryColor:String?
    var tertiaryColor:String?
    var quaternaryColor:String?
    var wikipediaLogoUrl:String?
    var wikipediaWordMarkUrl:String?
    var globalTeamId:Int?
    var nbaId:Int?
    
    var players:[Player]?
    
    enum CodingKeys: String, CodingKey {
        case teamId = "TeamID"
        case key = "Key"
        case active = "Active"
        case city = "City"
        case name = "Name"
        case leagueId = "LeagueID"
        case stadiumId = "StadiumID"
        case conference = "Conference"
        case division = "Division"
        case primaryColor = "PrimaryColor"
        case secondaryColor = "SecondaryColor"
        case tertiaryColor = "TertiaryColor"
        case quaternaryColor = "QuaternaryColor"
        case wikipediaLogoUrl = "WikipediaLogoUrl"
        case wikipediaWordMarkUrl = "WikipediaWordMarkUrl"
        case globalTeamId = "GlobalTeamID"
        case nbaId = "NbaDotComTeamID"
    }
    
    func getImageData() {
        
        // If there is a string...
        guard wikipediaLogoUrl != nil else {
            return
        }
        
        // If created url != nil...
        if let url = URL(string: wikipediaLogoUrl!) {
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                } else {
                    print("Unable to get image data")
                }
            }
            dataTask.resume()
        }
    }
    
    func getPlayerData() {
        if self.key == nil {
            return
        }
        
        let startUrl = Constants.apiPlayersUrl + self.key!
        
        var urlComponents = URLComponents(string: startUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        
                        var result = try decoder.decode([Player].self, from: data!)
                        
                        for p in result {
                            p.id = UUID()
                        }
                        
                        result = result.sorted {
                            $0.lastName!.localizedCaseInsensitiveCompare($1.lastName!) == ComparisonResult.orderedAscending
                        }
                        
                        DispatchQueue.main.async {
                            self.players = result
                        }
                          
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            dataTask.resume()
        }
    }
    
    static func hexCodeToColor(hexCode:String) -> UIColor {
        var rgbValue:UInt64 = 0
        
        // Remove any spaces or \n and set it to rgbValue
        Scanner(string: hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()).scanHexInt64(&rgbValue)
        
        // Return a UIColor based on the converted hex code
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
