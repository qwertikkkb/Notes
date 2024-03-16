
//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 23.01.2024.
//


import SwiftUI

struct ContentView: View {
    // Mark - Property
    @State private var notes: [Note] = []
    @State private var text: String = ""
    
    @AppStorage("lineCount") var lineCount: Int = 1

    // Mark - Functions
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data has failed")
        }
    }

    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
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

    // Mark - Body
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Notes", text: $text)

                    Button {
                        guard text.isEmpty == false else { return }

                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        text = ""
                        save()

                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                }// HStack

                Spacer()

                if notes.count >= 1 {
                    List {
                        ForEach(notes.indices, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundStyle(.accent)
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }// HStack
                            }
                        }// Loop
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
                }// List
            }// VStack
            .navigationTitle("Notes")
            .onAppear(perform: {
                load()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
