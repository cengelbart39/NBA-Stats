//
//  GamesView.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/5/21.
//

import SwiftUI

struct GamesView: View {
    
    @EnvironmentObject var model:GameModel
    
    @State var selectedDay = Constants.selectToday
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Title
            Text("Games")
                .font(.largeTitle)
                .bold()
                .padding([.leading, .top])
            
            // Day Picker
            Picker("Select Day", selection: $selectedDay) {
                Text("Yesterday").tag(Constants.selectYesterday)
                Text("Today").tag(Constants.selectToday)
                Text("Tomorrow").tag(Constants.selectTomorrow)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.top, 5)
            
            // Customize Picker
            .onAppear {
                
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(red: 182/255, green: 43/255, blue: 53/255))
                
                UISegmentedControl.appearance().backgroundColor = UIColor(Color(red: 38/255, green: 67/255, blue: 133/255))
                
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            }
            
            // Show next view
            GamesDayView(selectedDay: selectedDay)
        }
    }
}
