//
//  DetailCharactersTableViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 14.10.2021.
//

import UIKit

class DetailCharactersTableViewController: UITableViewController {

    var character: Character?
    var episode: Episode?
    var location: Location?
    var filteredCharacters: FilteredCharacters?
    private var filteredCharactersURL = URLS.filteredCharacter.rawValue
    var charImage: UIImage?

    private var header: CustomHeader!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.alpha = 0
        self.navigationController?.navigationBar.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.tableView.alpha = 1
            self.navigationController?.navigationBar.alpha = 1
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white

        getImage()
        self.tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        self.tableView.register(UINib(nibName: "DetailLocationAndEpisodeCell", bundle: nil), forCellReuseIdentifier: "DetailLocationAndEpisodeCell")
        self.tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: "collectionCell")
        self.tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 0
        if self.episode == nil, self.location == nil {
            sectionCount = 4
        } else if self.character == nil, self.location == nil {
            sectionCount = 2
        } else if self.character == nil, self.episode == nil {
            sectionCount = 2
        }
        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfSection = 0

        if self.episode == nil, self.location == nil {
            switch section {
            case 0:
                numberOfSection = 4
            case 1:
                numberOfSection = 1
            case 2:
                numberOfSection = self.character?.episode.count ?? 0
            case 3:
                numberOfSection = 1
            default:
                break

            }
        } else if self.character == nil, self.location == nil {
            switch section {
            case 0:
                numberOfSection = 2
            case 1:
                numberOfSection = self.episode?.characters.count ?? 0
            default:
                break
            }
        } else if self.character == nil, self.episode == nil {
            switch section {
            case 0:
                numberOfSection = 3
            case 1:
                numberOfSection = self.location?.residents?.count ?? 0
            default:
                break
            }
        }
        return numberOfSection
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        var content = cell.defaultContentConfiguration()


        if self.episode == nil, self.location == nil {
            switch indexPath {
            case [0,0]:
                content.text = "Status"
                content.secondaryText = self.character?.status
                cell.contentConfiguration = content

            case [0,1]:
                content.text = "Type"
                content.secondaryText = self.character?.species
                cell.contentConfiguration = content
            case [0,2]:
                content.text = "Gender"
                content.secondaryText = self.character?.gender
                cell.contentConfiguration = content
            case [0,3]:
                content.text = "Date"
                content.secondaryText = self.character?.created
                cell.contentConfiguration = content
            case [1,0]:
                content.text = self.character?.location.name
                cell.contentConfiguration = content
            case [3,0]:
                cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! CollectionViewTableViewCell

            default:
                if indexPath >= [2,0], indexPath < [3,0] {
                    cell = tableView.dequeueReusableCell(withIdentifier: "episCell", for: indexPath)
                    NetworkManager.shared.fetchEpisode(from: self.character?.episode[indexPath.row] ?? "", completion: { result in
                        content.text = result.name
                        cell.contentConfiguration = content
                    })
                }
            }
        } else if self.character == nil, self.location == nil {
            switch indexPath {
            case [0,0]:
                content.text = "Date"
                content.secondaryText = self.episode?.date
                cell.contentConfiguration = content
            case [0,1]:
                content.text = "Code"
                content.secondaryText = self.episode?.episode
                cell.contentConfiguration = content
            default:
                let charactersCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
                NetworkManager.shared.fetchCharacter(from: self.episode?.characters[indexPath.row] ?? "") { result in
                    DispatchQueue.main.async {
                        let character = result
                        charactersCell.configureForCharacter(with: character)
                    }
                }
                return charactersCell
            }

        } else if self.character == nil, self.episode == nil {
            switch indexPath {
            case [0,0]:
                content.text = "Type"
                content.secondaryText = self.location?.type
                cell.contentConfiguration = content
            case [0,1]:
                content.text = "Dimension"
                content.secondaryText = self.location?.dimension
                cell.contentConfiguration = content
            case [0,2]:
                content.text = "Date"
                content.secondaryText = self.location?.created
                cell.contentConfiguration = content
            default:
                let charactersCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
                NetworkManager.shared.fetchCharacter(from: self.location?.residents?[indexPath.row] ?? "") { result in
                    let character = result
                    charactersCell.configureForCharacter(with: character)
                }
                return charactersCell
            }

        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""

        if self.episode == nil, self.location == nil {
            switch section {
            case 1:
                title = "LOCATION"
            case 2:
                title = "EPISODES"
            case 3:
                title = "SIMILIAR CHARACTERS"
            default:
                break
            }
        } else if self.character == nil, self.location == nil {
            switch section {
            case 1:
                title = "CHARACTERS IN EPISODE"
            default:
                break
            }
        } else if self.character == nil, self.episode == nil {
            switch section {
            case 1:
                title = "CHARACTERS IN LOCATION"
            default:
                break
            }
        }

        return title
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as? CustomHeader
        headerView?.favoriteButtonPressed.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        headerView?.charImage.image = self.charImage
        headerView?.charName.text = self.character?.name

        if self.episode == nil, self.location == nil {
            headerView?.charName.text = self.character?.name
            if CoreDataManager.shared.fetchCharacters().filter({$0.id == self.character?.id ?? 0}).isEmpty == false {
                headerView?.favoriteButtonPressed.setTitle("In Favorites", for: .normal)
                headerView?.favoriteButtonPressed.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                headerView?.favoriteButtonPressed.tintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
            }
        } else if self.character == nil, self.location == nil {
            headerView?.charName.text = self.episode?.name
            headerView?.leadingConstraintOfStackView.constant = 10
            if CoreDataManager.shared.fetchEpisodes().filter({$0.name == self.episode?.name ?? ""}).isEmpty == false {
                headerView?.favoriteButtonPressed.setTitle("In Favorites", for: .normal)
                headerView?.favoriteButtonPressed.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                headerView?.favoriteButtonPressed.tintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
            }
        } else if self.character == nil, self.episode == nil {
            headerView?.charName.text = self.location?.name
            headerView?.leadingConstraintOfStackView.constant = 10
            if CoreDataManager.shared.fetchLocations().filter({$0.name == self.location?.name ?? ""}).isEmpty == false {
                headerView?.favoriteButtonPressed.setTitle("In Favorites", for: .normal)
                headerView?.favoriteButtonPressed.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                headerView?.favoriteButtonPressed.tintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
            }
        }
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView")
        guard section == 0 else { return 30 }
        return headerView?.frame.height ?? 100
    }

    func getImage(){
        ImageManager.shared.fetchImage(from: self.character?.image ?? "") { [weak self] data, response in
            DispatchQueue.main.async {
                self?.charImage = UIImage(data: data)
                self?.tableView.reloadData()
            }
        }
    }

    @objc func addToFavorites(){
        if self.episode == nil, self.location == nil {
            if CoreDataManager.shared.fetchCharacters().filter({$0.id == self.character?.id ?? 0}).isEmpty {
                CoreDataManager.shared.saveCharacter(char: self.character!)
            } else {
                guard let charForDelete = CoreDataManager.shared.fetchCharacters().filter({$0.id == self.character?.id ?? 0}).first else { return }
                CoreDataManager.shared.persistentContainer.viewContext.delete(charForDelete)
            }
        } else if self.character == nil, self.location == nil {
            if CoreDataManager.shared.fetchEpisodes().filter({$0.name == self.episode?.name ?? ""}).isEmpty {
                CoreDataManager.shared.saveEpisode(episode: self.episode!)
            } else {
                guard let epiForDelete = CoreDataManager.shared.fetchEpisodes().filter({$0.name == self.episode?.name ?? ""}).first else { return }
                CoreDataManager.shared.persistentContainer.viewContext.delete(epiForDelete)
            }
        } else if self.character == nil, self.episode == nil {
            if CoreDataManager.shared.fetchLocations().filter({$0.name == self.location?.name ?? ""}).isEmpty {
                CoreDataManager.shared.saveLocation(location: self.location!)
            } else {
                guard let locaForDelete = CoreDataManager.shared.fetchLocations().filter({$0.name == self.location?.name ?? ""}).first else { return }
                CoreDataManager.shared.persistentContainer.viewContext.delete(locaForDelete)
            }
        }
    }


    @IBAction func sharedButtomPressed(_ sender: UIBarButtonItem) {
        if self.episode == nil, self.location == nil {
            let shareController = UIActivityViewController(activityItems: ["Name: \(self.character?.name ?? "")","Status:  \(self.character?.status ?? "")", "Gender: \(self.character?.gender ?? "")"], applicationActivities: nil)
            present(shareController, animated: true, completion: nil)
        } else if character == nil, location == nil {
            let shareController = UIActivityViewController(activityItems: ["Name: \(self.episode?.name ?? "")","Date:  \(self.episode?.date ?? "")", "Episode: \(self.episode?.episode ?? "")"], applicationActivities: nil)
            present(shareController, animated: true, completion: nil)
        } else if character == nil, episode == nil {
            let shareController = UIActivityViewController(activityItems: ["Name: \(self.location?.name ?? "")","Dimension:  \(self.location?.dimension ?? "")", "Type: \(self.location?.type ?? "")"], applicationActivities: nil)
            present(shareController, animated: true, completion: nil)
        }
    }
}


extension DetailCharactersTableViewController: UICollectionViewDataSource, UICollectionViewDelegate  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionViewCell
        NetworkManager.shared.fetchCharacter(from: (URLS.filteredCharacter.rawValue + (self.character?.name.components(separatedBy: " ").first ?? ""))) { result in
            
            cell.name.text = result.name
            ImageManager.shared.fetchImage(from: result.image) { data, response in
                cell.image.image = UIImage(data: data) ?? UIImage(systemName: "person")!
            }

        }
        return cell
    }


}

