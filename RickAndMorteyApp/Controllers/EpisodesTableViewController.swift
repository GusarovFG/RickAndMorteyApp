//
//  EpisodesTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 01.11.2021.
//

import UIKit

class EpisodesTableViewController: UITableViewController {

    private var episodes: Episodes?
    private var epis: [Episode] = []
    private var beginFetch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEpisodes()

        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.title = "Episodes"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.epis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let episode = self.epis[indexPath.row]
        content.text = episode.name
        content.secondaryText = episode.episode
        cell.contentConfiguration = content
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "episodeDetail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as? DetailCharactersTableViewController
            detailVC?.episode = self.epis[indexPath.row]
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offSetY > contentHeight - scrollView.frame.height{
            if !self.beginFetch {
                fetchNextEpisodes()
            }
        }
    }

    private func fetchEpisodes(){
        NetworkManager.shared.fetchEpisodess(from: URLS.episodes.rawValue) { result in
            DispatchQueue.main.async {
                self.episodes = result
                self.epis = result.results
                self.tableView.reloadData()
            }
        }

    }
    private func fetchNextEpisodes() {
        self.beginFetch = true
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
            NetworkManager.shared.fetchEpisodess(from: self.episodes?.info.next) { result in
                self.episodes = result
                self.epis.append(contentsOf: result.results.compactMap{$0})
                self.tableView.reloadData()
                self.beginFetch = false
            }
        }
    }
}
