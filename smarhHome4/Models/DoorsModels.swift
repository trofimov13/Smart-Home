//
//  DoorsModels.swift
//  smartHome
//
//  Created by Алексей Трофимов on 02.06.2022.
//

import RealmSwift

struct DoorsModels: Codable {
    let success: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let name: String
    let room: String?
    let id: Int
    let favorites: Bool
    let snapshot: String?
}

