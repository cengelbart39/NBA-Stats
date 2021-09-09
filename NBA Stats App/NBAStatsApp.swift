//
//  NBAStatsApp.swift
//  NBA Scores App
//
//  Created by Christopher Engelbart on 7/3/21.
//

import SwiftUI
import SVGKit

@main
struct NBAStatsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(GameModel())
        }
    }
}
