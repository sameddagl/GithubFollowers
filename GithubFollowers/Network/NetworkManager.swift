//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 15.11.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://api.github.com"
    
    //MARK: - Get followers
    func getFollowers(username: String, page: Int, completion: @escaping(Result<[Follower], ErrorMessage>) -> Void) {
        let endPoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))//Error handling
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))//Error handling
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(decodedData))
            }
            catch{
                completion(.failure(.decodingData))
            }
        }.resume()
    }
    
    //MARK: - Get User Info
    func getUserInfo(for username: String, completion: @escaping(Result<User, ErrorMessage>) -> Void) {
        let endPoint = baseURL + "/users/\(username)"

        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(User.self, from: data)
                completion(.success(decodedData))
            }
            catch{
                completion(.failure(.decodingData))
            }
        }.resume()
    }
    
    //MARK: - Download avatar image
    func downloadAvatarImage(avatarURL: String, completion: @escaping(UIImage?) -> Void) {
        let url = URL(string: avatarURL)!
        
        let key = NSString(string: avatarURL)
        
        if let image = cache.object(forKey: key) {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            self?.cache.setObject(image!, forKey: key)
            completion(image)
            
        }.resume()
    }
}
