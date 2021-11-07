//
//  FavoritsCharactersViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import UIKit

class FavoritsCharactersViewController: UIViewController {

    var characters: [FavoritesCharacter] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.characters = CoreDataManager.shared.fetchCharacters()

        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
}

extension FavoritsCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
        print(indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            characters.remove(at: indexPath.row)
            CoreDataManager.shared.deleteCharacter(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func getImage(url: String, indexPath: Int) -> UIImage? {
        var image = UIImage()
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.main.async {
                image = UIImage(data: data) ?? UIImage(systemName: "eye")!
            }
        }
        return image
    }

}
