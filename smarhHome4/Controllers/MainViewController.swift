//
//  MainViewController.swift
//  smartHome
//
//  Created by Алексей Трофимов on 02.06.2022.
//

import UIKit
import RealmSwift

final class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var segmentedControlButton: UISegmentedControl!
    
    private let camerasUrl = "http://cars.cprogroup.ru/api/rubetek/cameras/"
    private let doorsUrl = "http://cars.cprogroup.ru/api/rubetek/doors/"
    private var myCameras: CamerasModels?
    private var myDoors: DoorsModels?
    
    var taskList: Results<TaskList>!
    var count = 0
    
    private var mainRefresh: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparationData()
        mainTableView.refreshControl = mainRefresh
    }
    
    //MARK: Navigation
    // подготовка данных перед переходом на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = mainTableView.indexPathForSelectedRow else {return}
        var detailImage = ""
        switch segmentedControlButton.selectedSegmentIndex {
        case 0: detailImage = taskList.first?.task[indexPath.section].snapshot ?? ""
        case 1: detailImage = taskList.last?.task[indexPath.section].snapshot ?? ""
        default: break
        }
        let detailVC = segue.destination as! DetailViewController
        detailVC.imageURL = detailImage
    }
    
    // MARK: Function
    
    //загрузка данных при включении
    private func preparationData(){
        taskList = DataManger.shared.realm.objects(TaskList.self)
        if taskList.isEmpty {
            loadData()
        }
    }
    
    //подготовка данных для первого включения
    private func loadData(){
        let groupOne = DispatchGroup()
            NetworkManager.shared.fetchCameras(from: self.camerasUrl) { myCameras in
                DispatchQueue.main.async(group: groupOne) {
                    self.myCameras = myCameras
                    self.renderCameras(myCameras: myCameras)
                    self.mainTableView.reloadData()
                }
            }
        groupOne.notify(queue: DispatchQueue.main) {
            NetworkManager.shared.fetchDoors(from: self.doorsUrl) { myDoors in
                DispatchQueue.main.async {
                    self.myDoors = myDoors
                    self.renderDoors(myDoors: myDoors)
                    self.mainTableView.reloadData()
                }
            }
        }
    }
    
    // таргет рефреша
    @objc func refresh(sender: UIRefreshControl){
        taskList = DataManger.shared.realm.objects(TaskList.self)
        if taskList.isEmpty {
            loadData()
        }
        segmentedControllTapped(segmentedControlButton)
        sender.endRefreshing()
    }
    
    //   обновление таблицы при нажатии на сегмент
    @IBAction func segmentedControllTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.mainTableView.reloadData()
        case 1:
            self.mainTableView.reloadData()
        default:
            break
        }
    }
    
    //    рендеринг данных с камер в БД
    private func renderCameras(myCameras: CamerasModels){
        let camerasList = TaskList()
        
        for i in 0..<myCameras.data.cameras.count  {
            let task = Task()
            task.name = myCameras.data.cameras[i].name
            task.favorites = myCameras.data.cameras[i].favorites
            task.snapshot =  myCameras.data.cameras[i].snapshot ?? ""
            task.room = myCameras.data.cameras[i].room ?? ""
            task.id = myCameras.data.cameras[i].id
            camerasList.task.append(task)
        }
        DataManger.shared.save(taskList: camerasList)
    }
    
    //    рендеринг данных с дверей в БД
    private func renderDoors(myDoors: DoorsModels){
        let doorsList = TaskList()
        
        for i in 0..<myDoors.data.count {
            let task = Task()
            task.name = myDoors.data[i].name
            task.favorites = myDoors.data[i].favorites
            task.snapshot =  myDoors.data[i].snapshot ?? ""
            task.room = myDoors.data[i].room ?? ""
            task.id = myDoors.data[i].id
            doorsList.task.append(task)
        }
        DataManger.shared.save(taskList: doorsList)
    }
    
}

