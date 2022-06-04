//
//  Extension + MainViewController.swift
//  smartHome3
//
//  Created by Алексей Трофимов on 03.06.2022.
//


import UIKit
import RealmSwift

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: TableView methods
    
    //кол-во ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    //кол-во секций
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segmentedControlButton.selectedSegmentIndex {
        case 0: count = (self.taskList.first?.task.count) ?? 0
        case 1: count = (self.taskList.last?.task.count) ?? 0
        default:
            break
        }
        return count
    }
    
    
    //настройка представления ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        switch segmentedControlButton.selectedSegmentIndex {
        case 0: cell.configure(with: taskList.first, indexPath: indexPath)
        case 1: cell.configure(with: taskList.last, indexPath: indexPath)
        default: break
        }
        return cell
    }
    
    
    //высота секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    
    //наименование секций
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch segmentedControlButton.selectedSegmentIndex {
        case 0: return taskList.first?.task[section].room ?? nil
        case 1: return taskList.last?.task[section].room ?? nil
        default: return nil
        }
    }
    
    
    //добавление кастомных кнопок по свайпу вправо для ячейки
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var task = taskList.first?.task[indexPath.section]
        switch segmentedControlButton.selectedSegmentIndex {
        case 0 :
            task = taskList.first?.task[indexPath.section]
        case 1:
            task = taskList.last?.task[indexPath.section]
        default: break
        }
        
        let editAction = UIContextualAction(style: .normal, title: "✏️") {(_, _, isDone) in
            self.showAlert(with: task!, indexPath: indexPath) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        let favoriteAction = UIContextualAction(style: .normal, title: "⭐️") {( _, _, isDone) in
            DataManger.shared.favorite(task: task!)
            isDone(true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        favoriteAction.backgroundColor = .systemGray2
        return UISwipeActionsConfiguration(actions: [editAction, favoriteAction])
    }
    
    //переход на второй экран по сигвею
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show", sender: nil)
    }
    
}


extension MainViewController {
    
    // настройка алерта для редактирования имени
    private func showAlert(with task: Task, indexPath: IndexPath, completion: (() -> Void)) {
        let alert = AlertController(title: "Edit Name", message: "Please insert new name", preferredStyle: .alert)
        
        alert.action(with: task) { newValue in
            DataManger.shared.edit(task: task, newName: newValue)
            self.mainTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        present(alert, animated: true)
    }
}
