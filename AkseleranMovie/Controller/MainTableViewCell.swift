//
//  MainTableViewCell.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewTop: UIImageView!
    var url = "https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    
    func setImage(with url:URL){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self.imageView?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
}
