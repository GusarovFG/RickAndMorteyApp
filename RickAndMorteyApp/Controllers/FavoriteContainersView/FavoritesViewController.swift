//
//  FavoritesViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 31.10.2021.
//

import UIKit


class FavoritesViewController: UIViewController {


    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var locationsView: UIView!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var charactersView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.segmentedControl.selectedSegmentIndex = 0
        
//        self.locationsView.isHidden = true
//        self.episodesView.isHidden = true

//        self.tableView.rowHeight = 60
//        self.tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "favorits")


    }
    

    @IBAction func reloadDataBySegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            charactersView.isHidden = false
            locationsView.isHidden = true
            episodesView.isHidden = true

            
        case 1:
            locationsView.isHidden = false
            charactersView.isHidden = true
            episodesView.isHidden = true
        case 2:
            episodesView.isHidden = false
            charactersView.isHidden = true
            locationsView.isHidden = true

        default:
            break
        }

    }
}

//extension FavoritesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var rows = 0
//        switch segmentedControl.selectedSegmentIndex {
//        case 0: rows = characters.count
//            self.tableView.reloadData()
//        case 1: rows = locations.count
//        case 2: rows = episodes.count
//        default:
//            rows = 0
//        }
//        return rows
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "favorits", for: indexPath) as! FavoriteTableViewCell
//        var content = cell.defaultContentConfiguration()
//        let character = self.characters[indexPath.row]
//        let location = self.locations[indexPath.row]
//        let episode = self.episodes[indexPath.row]
//
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            cell.configure(with: character)
//        case 1:
//            content.text = location.name
//            cell.contentConfiguration = content
//        case 2:
//            content.text = episode.name
//            cell.contentConfiguration = content
//        default:
//            break
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            characters.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            CoreDataManager.shared.deleteCharacter(index: indexPath.row)
//            CoreDataManager.shared.saveContext()
//        }
//    }
//
//    func getImage(with character: FavoritesCharacter?) -> UIImage {
//        var image = UIImage()
//        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
//            DispatchQueue.main.async {
//                image = UIImage(data: data) ?? UIImage(systemName: "multiply.circle.fill")!
//            }
//        }
//        return image
//    }




