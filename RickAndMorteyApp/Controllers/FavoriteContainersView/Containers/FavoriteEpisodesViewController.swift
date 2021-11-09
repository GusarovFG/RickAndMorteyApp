//
//  FavoriteEpisodesViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import UIKit

class FavoriteEpisodesViewController: UIViewController {

    var episodes: [FavoritesEpisodes] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.episodes = CoreDataManager.shared.fetchEpisodes()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.episodes = CoreDataManager.shared.fetchEpisodes()
        self.tableView.reloadData()
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EpisodeSegue" {
            let detailVC = segue.destination as! DetailCharactersTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let episode = self.episodes[indexPath?.row ?? 0]
            detailVC.episode = Episode(name: episode.name ?? "",
                                       date: episode.date ?? "",
                                       episode: episode.episode ?? "",
                                       characters: (episode.characters ?? [] as NSObject) as! [String])
            
        }
    }


}

extension FavoriteEpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteEpisodeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let episode = self.episodes[indexPath.row]
        content.text = episode.name
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.episodes.remove(at: indexPath.row)
            CoreDataManager.shared.deleteEpisode(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
