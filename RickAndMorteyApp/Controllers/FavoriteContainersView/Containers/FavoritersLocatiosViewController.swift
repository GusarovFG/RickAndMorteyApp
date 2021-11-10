//
//  FavoritersLocatiosViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import UIKit

class FavoritersLocatiosViewController: UIViewController {

    var locations: [FavoritesLocation] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView.rowHeight = 60
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locations = CoreDataManager.shared.fetchLocations()
        self.tableView.reloadData()
    }
}



extension FavoritersLocatiosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteLocationCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let location = locations[indexPath.row]
        content.text = location.name
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.locations.remove(at: indexPath.row)
            CoreDataManager.shared.deleteLocation(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailCharactersTableViewController
        guard let locationURL = self.locations[indexPath.row].url else { return }
        NetworkManager.shared.fetchLocation(from: locationURL) { result in
            detailVC.location = result
        }
        
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.frame.size = CGSize(width: 50, height: 50)
        button.frame.origin.x = 320
        detailVC.view.addSubview(button)
        detailVC.modalPresentationStyle = .fullScreen

        self.present(detailVC, animated: true, completion: nil)
    }

    @objc func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}
