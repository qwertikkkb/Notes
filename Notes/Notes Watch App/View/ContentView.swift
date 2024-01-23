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
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    
    func save() {
       // dump(notes)
        do {
            // 1. Convert the notes array to data using JSONDecoder
            let data = try JSONEncoder().encode(notes)
            
            // 2. Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // 3. Write the data to given URL
            try data.write(to: url)
            
        } catch {
            print("Saving data has failed")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                // 1. Get the notes URL path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                // 2. Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // 3. Decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            } catch {
                // Do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
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
            
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        HStack{
                            Capsule()
                                .frame(width: 4)
                                .foregroundStyle(.accent)
                            Text(notes[i].text)
                                .lineLimit(1)
                                .padding(.leading, 5)
                        }//HStack
                    }//Loop
                    .onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }//List
        }//VSTack
        .navigationTitle("Notes")
        .onAppear(perform: {
            load()
        })
    }
}

#Preview {
    ContentView()
}
