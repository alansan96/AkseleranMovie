//
//  CollectionViewCell.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .white
        
    }

    func loadImage(from url: URL) {
        imageView.image = nil
        
        URLSession.shared.dataTask(with: url) { (data, resposne, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = newImage
                
            }
            
        }.resume()
    }
    
    
}
