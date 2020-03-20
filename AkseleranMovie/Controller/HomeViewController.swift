//
//  ViewController.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - INIT
    var movies = [MovieModel]()
    var upcomingMovies = [MovieModel]()
    
    var detailId : Int? = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        
        fetchPopularMovie()
        fetchUpcomingMovie()
        
    }
    
    // MARK: - METHOD
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        tableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
    }
    
    func fetchPopularMovie(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=72ef68c471e5569b76642ad79a565f88&language=en-US&page=1")
        APIClient.shared.fetchMovieNowPlaying(with: url!) { (result) in
            switch result{
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUpcomingMovie(){
        let upcomingURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=72ef68c471e5569b76642ad79a565f88&language=en-US&page=1")
        APIClient.shared.fetchUpcomingMovie(with: upcomingURL!) { (result) in
            switch result{
            case .success(let movies):
                self.upcomingMovies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - TABLE VIEW

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 1
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! PopularTableViewCell
            cell2.updateCellWith(row: movies)
            cell2.cellDelegate = self
            return cell2
        }else if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
            cell.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")!)
            return cell
        }else {
           let cell2 = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! PopularTableViewCell
            cell2.updateCellWith(row: upcomingMovies)
            cell2.cellDelegate = self
            return cell2
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 || section == 2 {
            let headerView = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: nil, options: nil)?.first as! HeaderTableViewCell
            switch section {
            case 1:
                headerView.titleLabel.text = "Popular Movie"
            case 2:
                headerView.titleLabel.text = "Upcoming Movie"
            default:
                headerView.titleLabel.text = "Other Movie"
                
            }
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }else if indexPath.section == 1 || indexPath.section == 2 {
            return 250
        }
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMovieSegue"{
            let detailVC = segue.destination as! DetailMovieViewController
            detailVC.id = detailId
        }
    }
    
}

extension HomeViewController : CollectionViewCellDelegate {
    func collectionView(movieId: Int) {
        self.detailId = movieId
        performSegue(withIdentifier: "detailMovieSegue", sender: self)
    }
    
    
    
}
