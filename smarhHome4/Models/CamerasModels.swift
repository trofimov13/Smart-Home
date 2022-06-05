//
//  CamerasModels.swift
//  smartHome
//
//  Created by Алексей Трофимов on 02.06.2022.
//


// MARK: - CamerasModel
struct CamerasModels: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let room: [String]
    let cameras: [Camera]
}

// MARK: - Camera
struct Camera: Codable {
    let name: String
    let snapshot: String?
    let room: String?
    let id: Int
    let favorites, rec: Bool
}
