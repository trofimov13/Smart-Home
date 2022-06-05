//
//  DetailViewController.swift
//  smartHome
//
//  Created by Алексей Трофимов on 02.06.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    var imageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = UIImage(systemName: "play.slash")
        guard let imageURL = URL(string: imageURL) else {return}
        guard let imageData = try? Data(contentsOf: imageURL) else {return}
        DispatchQueue.main.async {
            self.detailImage.image = UIImage(data: imageData)
        }
    }
}
