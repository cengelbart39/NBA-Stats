//
//  RectangleCard.swift
//  NBA Stats App
//
//  Created by Christopher Engelbart on 7/6/21.
//

import SwiftUI

struct RectangleCard: View {
    
    var color:Color?
    var gradient:LinearGradient?
    
    var body: some View {
        
        // If there is a gradient...
        if gradient != nil {
            
            // Display the gradient
            Rectangle()
                .strokeBorder(gradient!, lineWidth: 10)
                .background(Rectangle().foregroundColor(color))
                .cornerRadius(10)
            
        } else {
            
            // Display the passed-in color
            Rectangle()
                .foregroundColor(color)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}
