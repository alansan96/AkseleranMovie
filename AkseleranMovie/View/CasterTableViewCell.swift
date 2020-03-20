//
//  CasterTableViewCell.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class CasterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var rowCaster = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }
    
    func setupLayout(){
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 2.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "CasterCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "cellID")
    }
    
}

extension CasterTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: [String]) {
        self.rowCaster = row
        print(self.rowCaster)
        self.collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowCaster.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CasterCollectionViewCell
        
        if let url = URL(string: rowCaster[indexPath.row]){
            print(url)
            cell.loadImage(from: url)
        }
        return cell
    }
    
}
