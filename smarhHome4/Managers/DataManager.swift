//
//  DataManager.swift
//  smartHome3
//
//  Created by Алексей Трофимов on 03.06.2022.
//

import RealmSwift

final class DataManger {
    
    static let shared = DataManger()
    let realm = try! Realm()
    
    private init() {}
    
    func save(taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func edit(task: Task, newName: String) {
        write {
            task.name = newName
        }
    }
    
    func favorite(task: Task) {
        write {
            task.favorites.toggle()
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
