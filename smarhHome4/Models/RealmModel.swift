//
//  RealmModel.swift
//  smartHome3
//
//  Created by Алексей Трофимов on 03.06.2022.
//

import RealmSwift

// MARK: - DoorsModelsRealm
class TaskList: Object{
    @Persisted var task: List<Task>
}

// MARK: - DatumRealm
class Task: Object {
    @Persisted var name: String = ""
    @Persisted var room: String = ""
    @Persisted var id: Int = 0
    @Persisted var favorites: Bool = true
    @Persisted var snapshot: String = ""
}


