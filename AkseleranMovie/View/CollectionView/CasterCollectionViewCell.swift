//
//  CasterCollectionViewCell.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class CasterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
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
