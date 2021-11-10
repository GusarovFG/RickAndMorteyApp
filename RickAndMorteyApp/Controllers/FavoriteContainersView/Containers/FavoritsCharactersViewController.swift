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

extension FavoritsCharactersViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let character = self.characters[indexPath.row]
        cell.configureForFavorite(with: character)
        print(indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.characters.remove(at: indexPath.row)
            CoreDataManager.shared.deleteCharacter(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailCharactersTableViewController
        NetworkManager.shared.fetchCharacter(from: self.characters[indexPath.row].url ?? "") { result in
            detailVC.character = result
        }
        ImageManager.shared.fetchImage(from: self.characters[indexPath.row].image ?? "") { data, response in
            detailVC.charImage = UIImage(data: data)
        }
        detailVC.modalPresentationStyle = .fullScreen
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.frame.size = CGSize(width: 40, height: 40)
        button.frame.origin.x = 340
        button.frame.origin.y = 60
        detailVC.view.addSubview(button)

        self.present(detailVC, animated: true, completion: nil)
    }

    @objc func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}
