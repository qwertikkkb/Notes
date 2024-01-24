//
//  Settings.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 24.01.2024.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    //functions
    func update() {
        lineCount = Int(value)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            //Header
            HeaderView(title: "Settings")
            
            // Actual line count
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            //Slider
            Slider(value: Binding(get: {
                self.value
            }, set: {(newValue) in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
            
        }//VStack
    }
}

#Preview {
    Settings()
}
