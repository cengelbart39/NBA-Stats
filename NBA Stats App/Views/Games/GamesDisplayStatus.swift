//
//  GamesDisplayStatus.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI

struct GamesDisplayStatus: View {
    
    var game:Game
    
    var body: some View {
        
        // If the game has a status and a startingDatatime
        if game.status != nil && game.startingDateTime != nil {
            
            // If the game's status is Scheduled and has a dateTime
            if game.status == "Scheduled" && game.dateTime != nil {
                
                // Display "Scheduled for XX:XX XM"
                Text("\(game.status!) for \(game.startingDateTime!)")
                    .padding(.top, 5)
            }
            
        // If the game just has a status
        } else if game.status != nil {
            
            // Display the status
            Text(game.status!)
                .padding(.top, 5)
        }
    }
}
