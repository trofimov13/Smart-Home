//
//  AlertController.swift
//  smartHome3
//
//  Created by Алексей Трофимов on 03.06.2022.
//

import UIKit

// создание алерт контроллера для редактирования имени
final class AlertController: UIAlertController {
    
    func action(with task: Task, completion: @escaping (String) -> Void) {
        
        let saveAction = UIAlertAction(title: "Update", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.text = task.name
        }
    }
}
