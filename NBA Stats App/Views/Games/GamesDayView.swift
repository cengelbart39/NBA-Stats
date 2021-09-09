//
//  GamesDayView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/7/21.
//

import SwiftUI

struct GamesDayView: View {
    
    @EnvironmentObject var model:GameModel
    var selectedDay:String
    
    var body: some View {
        
        // If "today" is selected...
        if selectedDay == Constants.selectToday {
            
            // If array contains no values...
            if model.todayGames!.count == 0 {
                
                // Show text
                GeometryReader { geo in
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("There are no games today")
                            .padding()
                        
                        Spacer()
                    }
                }
                
            } else {
                
                // Show games for that day
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.todayGames!) { game in
                            GamesCardView(selectedDay: selectedDay, game: game)
                        }
                    }
                }
            }
            
        // If "yesterday" is selected...
        } else if selectedDay == Constants.selectYesterday {
            
            // If array contains no values...
            if model.yesterdayGames!.count == 0 {
                
                // Show text
                GeometryReader { geo in
                    
                    HStack {
                        Spacer()
                            
                        Text("There were no games yesterday")
                            .padding()
                        
                        Spacer()
                    }
                }
                
            } else {
                
                // Show games for that day
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.yesterdayGames!) { game in
                            GamesCardView(selectedDay: selectedDay, game: game)
                        }
                    }
                }
            }
        
        // If "tomorrow" is selected...
        } else if selectedDay == Constants.selectTomorrow {
            
            // If array contains no values...
            if model.tomorrowGames!.count == 0 {
                
                // Show text
                GeometryReader { geo in
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("There are no games tomorrow")
                            .padding()
                        
                        Spacer()
                    }
                }
                
            } else {
                
                // Show games for that day
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.tomorrowGames!) { game in
                            GamesCardView(selectedDay: selectedDay, game: game)
                        }
                    }
                }
            }
        }
    }
}
