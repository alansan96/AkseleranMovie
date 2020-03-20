//
//  PopularTableViewCell.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionView( movieId: Int)
    // other delegate methods that you can define to perform action in viewcontroller
}

class PopularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var cellDelegate: CollectionViewCellDelegate?

    var rowMovies = [MovieModel]()
    var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }
    
    func setupLayout(){
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 140, height: 380)
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 2.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
    }
    
}

extension PopularTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: [MovieModel]) {
        self.rowMovies = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        print("tapping" , indexPath.item)
        self.cellDelegate?.collectionView(movieId: rowMovies[indexPath.item].id)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCell {
            
            if let url = URL(string: rowMovies[indexPath.row].posterlink){
                cell.loadImage(from: url)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
}
