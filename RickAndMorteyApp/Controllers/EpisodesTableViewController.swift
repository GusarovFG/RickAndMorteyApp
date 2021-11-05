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

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return epis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let episode = epis[indexPath.row]
        content.text = episode.name
        content.secondaryText = episode.episode
        cell.contentConfiguration = content
        
        return cell
    }

    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "episodeDetail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as? DetailCharactersTableViewController
            detailVC?.episode = epis[indexPath.row]
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offSetY > contentHeight - scrollView.frame.height{
            if !beginFetch {
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
        beginFetch = true
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
