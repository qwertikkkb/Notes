//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 23.01.2024.
//

import SwiftUI

struct DetailView: View {
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            //Header
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }//HStack
            .foregroundStyle(.accent)
            
            //Content
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            //Footer
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    Spacer()
                
                Text("\(count) / \(index + 1)")
              
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }//HStack
            .foregroundStyle(.secondary)
        }//VStack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Hello World")
    
    static var previews: some View {
    DetailView(note: sampleData, count: 5, index: 1)
 }
}
