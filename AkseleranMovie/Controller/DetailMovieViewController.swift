//
//  DetailMovieViewController.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    // MARK: - OUTLET
    
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var releaseDateGenreLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VARIABLE
    var id: Int!
    var casterList = [String]()
    var movieDetail: MovieDetail?
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        print(id)
        setupTableView()
        fetchDetailMovie(movieId: id)
        fetchCaster(movieId: id)
    }
    
    // MARK: - METHODS
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CasterTableViewCell", bundle: nil), forCellReuseIdentifier: "CasterCell")
        
        tableView.register(UINib(nibName: "StorylineTableViewCell", bundle: nil), forCellReuseIdentifier: "StorylineCell")
    }
    
    func fetchDetailMovie(movieId : Int){
        let url = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=72ef68c471e5569b76642ad79a565f88&language=en-US"
        
        APIClient.shared.fetchDetailMovie(with: URL(string: url)!) { (result) in
            switch result{
            case .success(let movieDetail):
                self.movieDetail = movieDetail
                DispatchQueue.main.async {
                    self.titleLabel.text = movieDetail.title
                    self.durationLabel.text = "\(movieDetail.runtime!) minutes"
                    self.voteLabel.text = "\(movieDetail.voteCount!) votes"
                    self.releaseDateGenreLabel.text = "\(movieDetail.releaseDate!) - \(movieDetail.genres![0].name!)"
                    self.loadBannerImage(path: movieDetail.backdropPath!)
                    self.loadPosterImage(path: movieDetail.posterPath!)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCaster(movieId : Int){
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=72ef68c471e5569b76642ad79a565f88"
        
        APIClient.shared.fetchCasting(with: URL(string: url)!) { (result) in
            switch result{
            case .success(let caster):
                caster.cast?.forEach({ (cast) in
                    if let profile = cast.profilePath {
                        self.casterList.append("https://image.tmdb.org/t/p/original/\(profile)")
                    }
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func loadBannerImage(path: String){
        let url = "https://image.tmdb.org/t/p/original\(path)"
        APIClient.shared.loadImage(from: URL(string: url)!) { (result) in
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageBanner.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadPosterImage(path: String){
        let url = "https://image.tmdb.org/t/p/original\(path)"
        APIClient.shared.loadImage(from: URL(string: url)!) { (result) in
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    self.imagePoster.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

// MARK: - TABLEVIEW
extension DetailMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CasterCell", for: indexPath) as! CasterTableViewCell
            cell.updateCellWith(row: casterList)
            return cell
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StorylineCell", for: indexPath) as! StorylineTableViewCell
            if let storyline = movieDetail?.overview {
                cell.textView.text = storyline
            }else{
                cell.textView.text = "Overview not available"
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "The Cast"
        }else if section == 1 {
            return "Storyline"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }else if indexPath.section == 1 {
            return 200
        }
        return UITableView.automaticDimension
    }
    
    
}
