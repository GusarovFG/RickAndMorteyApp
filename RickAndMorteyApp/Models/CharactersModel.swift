//
//  NetworkPresenter.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 03.10.2021.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Episodes: Decodable {
    let info: Info
    let results: [Episode]
}

struct Locations: Decodable {
    let info: Info
    let results: [Location]
}

struct FilteredCharacters: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Decodable {
    let name: String
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
    
}

struct Episode: Decodable {
    let name: String
    let date: String
    let episode: String
    let characters: [String]/Users/faddejgusarov/Desktop/RickAndMorteyApp/RickAndMorteyApp/Controllers/EpisodesTableViewController.swift
 
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}

