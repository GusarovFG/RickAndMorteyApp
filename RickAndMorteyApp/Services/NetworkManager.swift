//
//  NetworkManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.10.2021.
//


import UIKit

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchData(from url: String?, with complition: @escaping (RickAndMorty) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    complition(rickAndMorty)
                }
            } catch let error {
                print(error)
            }

        }.resume()
    }

    func fetchEpi(from url: String?, with complition: @escaping (Episode) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else { return }

            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    complition(episode)
                }
            } catch let error {
                print(error)
            }

        }.resume()
    }

    func fetchEpisode(from url: String, completion: @escaping(Result<Episode, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no descripption")
                return
            }

            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(episode))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCharacter(from url: String, completion: @escaping(Character) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no descripption")
                return
            }

            do {
                let result = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

class ImageManager {
    
    static var shared = ImageManager()

    private init() {}

    func fetchImage(from url: String, complition: @escaping (Data, URLResponse) -> ()) {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            guard imageURL == response.url else { return }

            complition(data, response)

        }.resume()
    }
}

