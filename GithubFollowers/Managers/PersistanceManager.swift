//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 23.11.2022.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

struct PersistanceManager {
    static let shared = PersistanceManager()
    private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping(ErrorMessage?) -> Void ) {
        retrieveData { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completion(save(favorites: favorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    func retrieveData(completion: @escaping(Result<[Follower], ErrorMessage>) -> Void)
    {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
            
        }
        
        do {
            let decodedData = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completion(.success(decodedData))
        }
        catch {
            completion(.failure(.decodingData))
        }
        
    }
    
    private func save(favorites: [Follower]) -> ErrorMessage? {
        do {
            let encodedData = try JSONEncoder().encode(favorites)
            defaults.set(encodedData, forKey: Keys.favorites)
            return nil
        }
        catch {
            return .unableToFavorite
        }
    }
}
