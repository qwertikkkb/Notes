//
//  Note.swift
//  Notes Watch App
//
//  Created by Nicolai Bodean on 23.01.2024.
//

import Foundation


struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
