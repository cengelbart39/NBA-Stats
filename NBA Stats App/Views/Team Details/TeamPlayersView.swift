//
//  TeamPlayersView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/23/21.
//

import SwiftUI

struct TeamPlayersView: View {
    
    var players:[Player]
    
    var items: [GridItem] = [
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
            ForEach(players) { player in
                VStack(alignment: .leading) {
                    Text((player.firstName ?? "") + " " + (player.lastName ?? ""))
                }
            }
        }
    }
}
