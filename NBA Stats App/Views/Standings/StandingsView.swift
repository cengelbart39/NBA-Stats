//
//  StandingsView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI

struct StandingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var model:GameModel
    
    @State var selectedConference = Constants.selectEasternConference
    
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        
        NavigationView {
        
            VStack(alignment: .leading) {
                
                // Title
                Text("Standings")
                    .font(.largeTitle)
                    .bold()
                    .padding([.leading, .top])
                
                // Picker
                Picker("Select Conference", selection: $selectedConference) {
                    Text("Eastern Conference")
                        .tag(Constants.selectEasternConference)
                    Text("Western Conference")
                        .tag(Constants.selectWesternConference)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 0)
                
                // Section header
                Section(header:
                            
                            HStack(spacing: 15) {
                                Text("#")
                                Text("Team Name")
                                Spacer()
                                Text("W - L")
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, -5)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                ) {
                    ScrollView {
                        
                        VStack() {
                            
                            // If it is the eastern conference show its games
                            if selectedConference == Constants.selectEasternConference {
                                ForEach(0..<model.currentEasternStandings.count) { index in
                                    
                                    NavigationLink(destination: TeamDetailView(standing: model.currentEasternStandings[index])) {
                                        StandingsRowView(conference: model.currentEasternStandings[index], index: index)
                                            .accentColor(colorScheme == .light ? .black : .white)
                                            
                                    }

                                }
                                
                                // If it is the western conference show its games
                            } else {
                                ForEach(0..<model.currentWesternStandings.count) { index in
                                    
                                    NavigationLink(destination: TeamDetailView(standing: model.currentWesternStandings[index])) {
                                        StandingsRowView(conference: model.currentWesternStandings[index], index: index)
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
        
    }
        
}

