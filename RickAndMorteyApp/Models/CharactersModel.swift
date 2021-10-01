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
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String

}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
    let date: String
    let episode: String
    let characters: [Character]


    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
}

enum URLS: String {
    case rickAndMortyapi = "https://rickandmortyapi.com/api/character"
}