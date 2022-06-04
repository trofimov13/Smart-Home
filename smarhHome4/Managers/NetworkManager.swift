//
//  NetworkManager.swift
//  smartHome3
//
//  Created by Алексей Трофимов on 02.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    // получение джейсона по камерам
    func fetchCameras(from urlString: String, with comlition: @escaping (CamerasModels) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let myCamerasModels = try JSONDecoder().decode(CamerasModels.self, from: data)
                comlition(myCamerasModels)
                
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
    
    //получение джейсона по дверям
    func fetchDoors(from urlString: String, with comlition: @escaping (DoorsModels) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let myDoorsModels = try JSONDecoder().decode(DoorsModels.self, from: data)
                comlition(myDoorsModels)
                
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
}
