//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 24.01.2024.
//

import SwiftUI

struct CreditsView: View {
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    
    var body: some View {
        VStack(spacing: 3) {
            //Profile Image
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            //Header
            HeaderView(title: "Credits")
            
            //Content
            Text("Nicolai Bodean")
                .foregroundStyle(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
            
        }//VSTAck
    }
}

#Preview {
    CreditsView()
}
