//
//  FavoritesViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 31.10.2021.
//

import UIKit


class FavoritesViewController: UIViewController {

    var characters: [FavoritesCharacter] = []
    var image: UIImage?


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.characters = CoreDataManager.shared.fetchCharacters()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)

        self.tableView.rowHeight = 60
        self.tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "favorits")


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func reloadDataBySegmentedControl(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch segmentedControl.selectedSegmentIndex {
        case 0: rows = characters.count
//        case 1: rows = locations.count
//        case 2: rows = episodes.count
        default:
            rows = 0
        }
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorits", for: indexPath) as! FavoriteTableViewCell
        let character = characters[indexPath.row]
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.configure(with: character)
//
//        case 1: cell.textLabel?.text = location
//        case 2: cell.textLabel?.text = episode
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            characters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.persistentContainer.viewContext.delete(characters[indexPath.row])
            CoreDataManager.shared.saveContext()
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


