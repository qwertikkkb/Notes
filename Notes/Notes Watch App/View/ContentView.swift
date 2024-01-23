//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 23.01.2024.
//

import SwiftUI

struct ContentView: View {
     //Mark - Property
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    
     //Mark - Functions
    func save() {
        dump(notes)
    }
    
    
     //Mark - Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Notes", text: $text)
                
                Button {
                    // 1. Only run the button's when the text field is not empty
                    guard text.isEmpty == false else {return}
                    
                    // 2. Create a new note item and initialize it with the text value
                    let note = Note(id: UUID(), text: text)
                    
                    // 3. Add the note item to the notes array (append)
                    notes.append(note)
                    
                    // 4. Make the field empty
                    text = ""
                    
                    // 5. Save the notes (functions)
                    save()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
               // .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }//HStack
            
            Spacer()
            
            Text("\(notes.count)")
        }//VSTack
        .navigationTitle("Notes")
    }
}

#Preview {
    ContentView()
}
