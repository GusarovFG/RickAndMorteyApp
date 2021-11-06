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

        self.episodes = CoreDataManager.shared.fetchEpisodes()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteEpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteEpisodeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let episode = episodes[indexPath.row]
        content.text = episode.name
        cell.contentConfiguration = content
        return cell
    }


}
