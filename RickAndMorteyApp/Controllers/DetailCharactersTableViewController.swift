//
//  DetailCharactersTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 14.10.2021.
//

import UIKit

class DetailCharactersTableViewController: UITableViewController {



//    weak var detailDelegate: DetailCharacterDelegate?
    var character: Character?
    var characterImage: UIImage?
    var episodes: [String] = []
    var parsEpisodes: [Episode?] = []



    override func viewDidLoad() {
        super.viewDidLoad()
        getEpisodes()

//        character = detailDelegate?.fetchChar()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfSection = 0
        if section == 0 {
            numberOfSection = 4
        } else if section == 1 {
            numberOfSection = 1
        } else {
            numberOfSection = character?.episode.count ?? 0
        }
        return numberOfSection
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        if indexPath == [0,0] {
            content.text = "Status"
            content.secondaryText = character?.status
            cell.contentConfiguration = content

        } else if indexPath == [0,1] {
            content.text = "Type"
            content.secondaryText = character?.species
            cell.contentConfiguration = content

        } else if indexPath == [0,2] {
            content.text = "Gender"
            content.secondaryText = character?.gender
            cell.contentConfiguration = content

        } else if indexPath == [0,3] {
            content.text = "Date"
            content.secondaryText = character?.created
            cell.contentConfiguration = content

        } else if indexPath == [1,0] {
            content.text = character?.location.name
            cell.contentConfiguration = content

        }   else {
            NetworkManager.shared.fetchEpisode(from: character?.episode[indexPath.row] ?? "") { result in
                switch result {
                case .success(let episode):
                    content.text = episode.name
                    cell.contentConfiguration = content
                case .failure(let error):
                    print(error)
                }
            }

    }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titlee = ""
        if section == 0 {
            titlee = "NAME"
        } else if section == 1{
            titlee = "LOCATION"
        } else if section == 2{
            titlee = "EPISODES"
        }
        return titlee
    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard section == 0 else { return nil }
//        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
//        let headerView = UIView(frame: frame)
//        let imageView = UIImageView()
//        imageView.image = self.characterImage ?? UIImage(systemName: "eye")
//        headerView.addSubview(imageView)
//        headerView.backgroundColor = UIColor.darkGray
//        return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        guard section == 0 else { return 30 }
//        return 150
//        }


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

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func getEpisodes(){
        for i in 0..<((character?.episode.count)!) {
            NetworkManager.shared.fetchEpi(from: character?.episode[i]) { episode in
                DispatchQueue.main.async {
                    self.parsEpisodes.append(episode)
                    print(self.parsEpisodes)
                }
            }
        }
    }
}



