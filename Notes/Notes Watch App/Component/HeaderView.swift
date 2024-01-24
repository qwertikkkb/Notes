//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 24.01.2024.
//

import SwiftUI

struct HeaderView: View {
    var title: String = ""
    
    var body: some View {
        VStack {
            //Title
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
            }
            
            //Separator
            
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }//HStack
            .foregroundStyle(.accent)
        }//VStack
    }
}

#Preview {
    Group {
        HeaderView(title: "Credits")
        
        HeaderView()
    }
}
