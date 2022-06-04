//
//  TableViewCell.swift
//  smartHome3
//
//  Created by Алексей Трофимов on 02.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var recLabel: UILabel!
    
    //настройка виды ячейки для дверей
    func configure(with myTasks: TaskList?, indexPath: IndexPath ) {
        self.mainImage.image = UIImage(systemName: "play.slash")
        guard let myTasks = myTasks else {return}
        let myTask = myTasks.task[indexPath.section]
        nameLabel.text = myTask.name
        
        if myTask.favorites {
            statusImage.image = UIImage(systemName: "star.fill")
        } else {
            statusImage.image = UIImage(systemName: "star")
        }
        DispatchQueue.main.async {
            if  myTask.snapshot != "" {
                let stringURL = myTask.snapshot
                guard let imageURL = URL(string: stringURL) else {return}
                guard let imageData = try? Data(contentsOf: imageURL) else {return}
                self.mainImage.image = UIImage(data: imageData)
            }
        }
    }
}
