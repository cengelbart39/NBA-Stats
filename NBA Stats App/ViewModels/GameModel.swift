//
//  GameModel.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/4/21.
//

import Foundation
import SwiftUI

class GameModel: ObservableObject {
    
    // Teams Array
    @Published var teams = [Team]()
    
    // Games array
    @Published var yesterdayGames:[Game]? = nil
    @Published var todayGames:[Game]? = nil
    @Published var tomorrowGames:[Game]? = nil
    
    // Current season for standings
    @Published var currentSeason:Season?
    
    // Standings array
    @Published var currentEasternStandings = [Standing]()
    @Published var currentWesternStandings = [Standing]()
    
    @Published var favoriteTeam:Int? = nil
    
    // Whether games are retrieved
    @Published var haveYesterdayGames = false
    @Published var haveTodayGames = false
    @Published var haveTomorrowGames = false
    
    @Published var areOnGoingGames = false
    
    init() {
        getTeamsData()
        areGamesInProgress()
        getCurrentSeason()
    }
    
    // MARK: - Data-Fetching Methods
    
    func getTeamsData() {
        var urlComponents = URLComponents(string: Constants.apiTeamsUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, respone, error in
                if error == nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        var result = try decoder.decode([Team].self, from: data!)
                        
                        // Give each team a UUID
                        for index in 0..<result.count {
                            result[index].id = UUID()
                        }
                        
                        // Get the logo image data for each team
                        for t in result {
                            t.getImageData()
                            t.getPlayerData()
                        }
                        
                        // Sort teams alphabetically
                        result = result.sorted {
                            $0.city!.localizedCaseInsensitiveCompare($1.city!) == ComparisonResult.orderedAscending
                        }
                        
                        DispatchQueue.main.async {
                            self.teams = result
                        }
                        
                        self.getGames(day: Constants.selectYesterday)
                        self.getGames(day: Constants.selectToday)
                        self.getGames(day: Constants.selectTomorrow)
                    } catch {
                        print("Error: Unable to decode Teams JSON data")
                    }
                }
                
            }
            dataTask.resume()
        }
    }
    
    func getGames(day: String) {
        // Get initial url
        let urlStart = Constants.apiScoresUrl
        
        // Create data and calendar
        var date = Date()
        let calendar = Calendar.current
        
        // Create yesterday and tomorrow variables
        var yesterday:Date? = nil
        var tomorrow:Date? = nil
        
        if day == Constants.selectYesterday {
            // if "yesterday" is passed in, subtract a day from the current day
            yesterday = calendar.date(byAdding: .day, value: -2, to: Date())
        } else if day == Constants.selectTomorrow {
            // if "tomorrow" is passed in, subtract a day from the current day
            tomorrow = calendar.date(byAdding: .day, value: 0, to: Date())
        } else {
            date = calendar.date(byAdding: .day, value: -1, to: Date())!
        }
            // else do nothing as date is set is today
        
        // Create data formatter
        let format = DateFormatter()
        
        // Format the date to two digits (i.e. 07, 10, 29, etc.)
        format.dateFormat = "dd"
        
        // Create day key for passed in date to API
        var dayKey = String()
        
        if day == Constants.selectYesterday {
            // if "yesterday" is passed in set the dateKey to the formatted day
            dayKey = format.string(from: yesterday!)
        } else if day == Constants.selectToday {
            // if "today" is passed in set the dateKey to the formatted day
            dayKey = format.string(from: date)
        } else {
            // if "tomorrow" is passed in set the dateKey to the formatted day
            dayKey = format.string(from: tomorrow!)
        }
        
        // Format the date to display: Jul, Feb, Dec, etc.
        format.dateFormat = "MMM"
        
        // Create monthKey for passed in date to API
        var monthKey = String()
        
        if day == Constants.selectYesterday {
            // if "yesterday" is passed in set the monthKey to the formatted day
            monthKey = format.string(from: yesterday!)
        } else if day == Constants.selectToday {
            // if "today" is passed in set the monthKey to the formatted day
            monthKey = format.string(from: date)
        } else {
            // if "tomorrow" is passed in set the monthKey to the formatted day
            monthKey = format.string(from: tomorrow!)
        }
        
        // Make the month key all uppercased
        monthKey = monthKey.uppercased()
        
        // Create dateKey (i.e. 2021-JUL-07)
        let dateKey = "\(calendar.component(.year, from: date))-\(monthKey)-\(dayKey)"
        
        // Get full url before API Key
        let stringUrl = urlStart + dateKey
        
        // Add on API Key
        var urlComponents = URLComponents(string: stringUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        // Create URL
        let url = urlComponents?.url
        
        if let url = url {
            
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, respone, error in
                if error == nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        let result = try decoder.decode([Game].self, from: data!)
                        
                        // Give all Games a UUID
                        for index in 0..<result.count {
                            result[index].id = UUID()
                        }
                        
                        for g in result {
                            // If there is a past game or there is a today game and an ongoing game
                            if day == Constants.selectTomorrow || (day == Constants.selectToday && self.areOnGoingGames) {
                                // If the game scores does not equal nil
                                if g.awayTeamScore == nil && g.homeTeamScore == nil {
                                    // If the status of the game is "Scheduled"
                                    if g.status == Constants.scheduleStatus {
                                        // Set startingDateTime property (i.e. 9:40 PM)
                                        g.getStartingTime(game: g, returnFormat: "hh:mm")
                                    }
                                }
                            }
                        }
                        
                        // Get the gradients for each game
                        for g in result {
                            g.getGradient(game: g, teams: self.getTeamsForGame(game: g))
                        }
                        
                        DispatchQueue.main.async {
                            
                            switch day {
                            
                            // If "yesterday" is passed in
                            case Constants.selectYesterday:
                                self.yesterdayGames = result
                                self.haveYesterdayGames = true
                                
                            // If "today" is passed in
                            case Constants.selectToday:
                                self.todayGames = result
                                self.haveTodayGames = true
                            
                            // If "tomorrow" is passed in
                            case Constants.selectTomorrow:
                                self.tomorrowGames = result
                                self.haveTomorrowGames = true
                                
                            default:
                                break
                            }
                        }
                    } catch {
                        print("Error: Unable to decode Game JSON data")
                    }
                }
                
            }
            dataTask.resume()
        }
    }
    
    func areGamesInProgress() {
        var urlComponents = URLComponents(string: Constants.apiGamesInProgressUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, respone, error in
                if error == nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        let result = try decoder.decode(Bool.self, from: data!)
                        
                        DispatchQueue.main.async {
                            self.areOnGoingGames = result
                        }
                    } catch {
                        print("Error: Unable to decode if there are any ongoing games")
                    }
                }
                
            }
            dataTask.resume()
        }
    }
    
    func getCurrentSeason() {
        var urlComponents = URLComponents(string: Constants.apiCurrentSeasonUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, respone, error in
                if error == nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        let result = try decoder.decode(Season.self, from: data!)
                        
                        // Once the data is decoded pass the apiSeason property to get the current standings
                        self.getCurrentStandings(apiSeason: result.apiSeason)
                        
                        DispatchQueue.main.async {
                            self.currentSeason = result
                        }
                    } catch {
                        print("Error: Unable to decode what the current season is")
                    }
                }
                
            }
            dataTask.resume()
        }
    }
    
    func getCurrentStandings(apiSeason: String?) {
        if apiSeason == nil {
            return
        }
        
        let startUrl = Constants.apiStandingsUrl + apiSeason!
        
        var urlComponents = URLComponents(string: startUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, respone, error in
                if error == nil {
                    do {
                        let decoder = JSONDecoder()
                        
                        let result = try decoder.decode([Standing].self, from: data!)
                        
                        var easternConference = [Standing]()
                        var westernConference = [Standing]()
                        
                        // Depending on conference property assign to one of the arrays
                        for s in result {
                            if s.conference == "Eastern" {
                                easternConference.append(s)
                            } else if s.conference == "Western" {
                                westernConference.append(s)
                            }
                        }
                        
                        // Sort standings by percentage
                        easternConference.sort { e1, e2 in
                            return e1.percentage ?? 0 > e2.percentage ?? 0
                        }
                        
                        westernConference.sort { w1, w2 in
                            return w1.percentage ?? 0.0 > w2.percentage ?? 0.0
                        }
                        
                        DispatchQueue.main.async {
                            self.currentEasternStandings = easternConference
                            self.currentWesternStandings = westernConference
                        }
                    } catch {
                        print("Error: Unable to decode the current standings")
                    }
                }
                
            }
            dataTask.resume()
        }
    }
    
    // MARK: - Data-Filtering Methods
    
    func getTeamsForGame(game: Game) -> [String:Team] {
        // Get team ids
        let awayTeamId = game.awayTeamId
        let homeTeamId = game.homeTeamId
        
        var output = [String:Team]()
        
        for team in self.teams {
            // If the team has the same team id as the game's away team...
            if team.teamId == awayTeamId {
                // Add team assigned to "Away"
                output[Constants.awayKey] = team
            }
            // If the team has the same team id as the game's home team...
            if team.teamId == homeTeamId {
                // Add team assigned to "Home"
                output[Constants.homeKey] = team
            }
            // Don't continue once the dictionary has two entries
            if output.count == 2 {
                break
            }
        }
        
        return output
    }
    
    func getTeamsForGame(game: Game, teams:[Team]) -> [String:Team] {
        // Get team ids
        let awayTeamId = game.awayTeamId
        let homeTeamId = game.homeTeamId
        
        var output = [String:Team]()
        
        for team in teams {
            // If the team has the same team id as the game's away team...
            if team.teamId == awayTeamId {
                // Add team assigned to "Away"
                output[Constants.awayKey] = team
            }
            // If the team has the same team id as the game's home team...
            if team.teamId == homeTeamId {
                // Add team assigned to "Home"
                output[Constants.homeKey] = team
            }
            // Don't continue once the dictionary has two entries
            if output.count == 2 {
                break
            }
        }
        
        return output
    }
    
    func favoriteReorder() {
        // If the games array != nil...
        if self.yesterdayGames != nil {
            // If the array contains entries...
            if self.yesterdayGames!.count != 0 {
                // Sort the array
                self.yesterdayGames!.sort { g1, g2 in
                    // Determine whether the games have a favorite team playing
                    g1.isFavoriteGame(teams: self.teams, favoriteTeam: self.favoriteTeam)
                    g2.isFavoriteGame(teams: self.teams, favoriteTeam: self.favoriteTeam)
                    
                    // Sort based on this property
                    return g1.isFavoriteGame != g2.isFavoriteGame
                }
            }
        }
        
        // If the games array != nil...
        if self.todayGames != nil {
            // If the array contains entries...
            if self.todayGames!.count != 0 {
                // Sort the array
                self.todayGames!.sort { g1, g2 in
                    // Determine whether the games have a favorite team playing
                    g1.isFavoriteGame(teams: self.teams, favoriteTeam: self.favoriteTeam)
                    g2.isFavoriteGame(teams: self.teams, favoriteTeam: self.favoriteTeam)
                    
                    // Sort based on this property
                    return g1.isFavoriteGame != g2.isFavoriteGame
                }
            }
        }
        
        // If the games array != nil...
        if self.tomorrowGames != nil {
            // If the array contains entries...
            if self.tomorrowGames!.count != 0 {
                // Sort the array
                self.tomorrowGames!.sort { g1, g2 in
                    // Determine whether the games have a favorite team playing
                    g1.isFavoriteGame(teams: self.teams, favoriteTeam: self.favoriteTeam)
                    g2.isFavoriteGame(teams: self.teams, favoriteTeam: self.favoriteTeam)
                    
                    // Sort based on this property
                    return g1.isFavoriteGame != g2.isFavoriteGame
                }
            }
        }
        
        self.setGradients()
    }
    
    func setGradients() {
        // Get necessary gradients
        if self.yesterdayGames != nil {
            if self.yesterdayGames!.count > 0 {
                for game in self.yesterdayGames! {
                    game.getGradient(game: game, teams: self.getTeamsForGame(game: game, teams: self.teams))
                }
            }
        }
        
        if self.todayGames != nil {
            if self.todayGames!.count > 0 {
                for game in self.todayGames! {
                    game.getGradient(game: game, teams: self.getTeamsForGame(game: game, teams: self.teams))
                }
            }
        }
        
        if self.tomorrowGames != nil {
            if self.tomorrowGames!.count > 0 {
                for game in self.tomorrowGames! {
                    game.getGradient(game: game, teams: self.getTeamsForGame(game: game, teams: self.teams))
                }
            }
        }
    }
    
    func getTeamFromStanding(standing: Standing) -> Team {
        
        var output = Team()
        
        for team in self.teams {
            if team.teamId == standing.teamId {
                output = team
                break
            }
        }
        
        return output
    }
}
