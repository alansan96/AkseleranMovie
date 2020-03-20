//
//  APIClient.swift
//  AkseleranMovie
//
//  Created by Alan Santoso on 20/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import Foundation
import UIKit


enum APIError : Error {
    case unknown
    case decodingError
    case badResponse
}


class APIClient {
    
    static var shared = APIClient()
    
    
    func fetchMovieNowPlaying(with url:URL, completion: @escaping(Swift.Result<[MovieModel], APIError>) -> ()){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.badResponse))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try jsonDecoder.decode(MovieResponse.self, from: jsonData)
                
                var movies = [MovieModel]()
                json.results?.forEach({ (res) in
                    let movie = MovieModel(id: res.id ?? 0, title: res.title ?? "asd", posterlink: res.posterPath ?? "asd")
                    movies.append(movie)
                })
                completion(.success(movies))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
        
    }
    
    func fetchUpcomingMovie(with url:URL, completion: @escaping(Swift.Result<[MovieModel], APIError>) -> ()){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.badResponse))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try jsonDecoder.decode(MovieResponse.self, from: jsonData)
                
                var movies = [MovieModel]()
                json.results?.forEach({ (res) in
                    let movie = MovieModel(id: res.id ?? 0, title: res.title ?? "asd", posterlink: res.posterPath ?? "asd")
                    movies.append(movie)
                })
                completion(.success(movies))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
        
    }
    
    func fetchDetailMovie(with url:URL, completion: @escaping(Swift.Result<MovieDetail, APIError>) -> ()){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.badResponse))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try jsonDecoder.decode(MovieDetail.self, from: jsonData)
                
                completion(.success(json))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
        
    }
    
    func fetchCasting(with url:URL, completion: @escaping(Swift.Result<Caster, APIError>) -> ()){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.badResponse))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try jsonDecoder.decode(Caster.self, from: jsonData)
                
                completion(.success(json))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
        
    }
    
    
    func loadImage(from url: URL, completion: @escaping(Swift.Result<UIImage, APIError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, resposne, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(newImage))
            
        }.resume()
    }
    
    
    
    
}
