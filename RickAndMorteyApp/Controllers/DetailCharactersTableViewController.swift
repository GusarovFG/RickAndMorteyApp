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
    var filteredCharactersURL = URLS.filteredCharacter.rawValue

    private var header: CustomHeader!
    private var charImage: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()


        getImage()
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        tableView.register(UINib(nibName: "DetailLocationAndEpisodeCell", bundle: nil), forCellReuseIdentifier: "DetailLocationAndEpisodeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfSection = 0

        if episode == nil, location == nil {
            switch section {
            case 0:
                numberOfSection = 4
            case 1:
                numberOfSection = 1
            case 2:
                numberOfSection = character?.episode.count ?? 0
            case 3:
                numberOfSection = 1
            default:
                break

            }
        } else if character == nil, location == nil {
            switch section {
            case 0:
                numberOfSection = 2
            default:
                break
            }
        } else if character == nil, episode == nil {
            switch section {
            case 0:
                numberOfSection = 3
            default:
                break
            }
        }

        return numberOfSection
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        if episode == nil, location == nil {

            switch indexPath {
            case [0,0]:
                content.text = "Status"
                content.secondaryText = character?.status
                cell.contentConfiguration = content
            case [0,1]:
                content.text = "Type"
                content.secondaryText = character?.species
                cell.contentConfiguration = content
            case [0,2]:
                content.text = "Gender"
                content.secondaryText = character?.gender
                cell.contentConfiguration = content
            case [0,3]:
                content.text = "Date"
                content.secondaryText = character?.created
                cell.contentConfiguration = content
            case [1,0]:
                content.text = character?.location.name
                cell.contentConfiguration = content

            case [3,0]:
                let collCell = tableView.dequeueReusableCell(withIdentifier: "collTableViewCell", for: indexPath) as! CollectionViewTableViewCell
                cell = collCell

            default:
                if indexPath <= [2,0], indexPath < [3,0] {
                    let episodesCell = tableView.dequeueReusableCell(withIdentifier: "cellWithAction", for: indexPath)
                    var cont = episodesCell.defaultContentConfiguration()
                    cont.text = self.character?.episode.first
                    episodesCell.contentConfiguration = cont
                    cell = episodesCell
                }
            }
        } else if character == nil, location == nil {

            switch indexPath {
            case [0,0]:
                content.text = "Date"
                content.secondaryText = episode?.date
                cell.contentConfiguration = content
            case [0,1]:
                content.text = "Code"
                content.secondaryText = episode?.episode
                cell.contentConfiguration = content
            default:
                break
            }
        } else if character == nil, episode == nil {

            switch indexPath {
            case [0,0]:
                content.text = "Type"
                content.secondaryText = location?.type
                cell.contentConfiguration = content
            case [0,1]:
                content.text = "Dimension"
                content.secondaryText = location?.dimension
                cell.contentConfiguration = content
            case [0,2]:
                content.text = "Date"
                content.secondaryText = location?.created
                cell.contentConfiguration = content
            default:
                break
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        if episode == nil, location == nil {
            if indexPath >= [3,0] {
                height = 160
            } else {
               height = UITableView.automaticDimension
            }
        }
        return height
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""

        if episode == nil, location == nil {
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
        } else if character == nil, location == nil {
            switch section {
            case 1:
                title = "CHARACTERS IN EPISODE"
            default:
                break
            }
        } else if character == nil, episode == nil {
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

        if episode == nil, location == nil {
            headerView?.charName.text = self.character?.name
        } else if character == nil, location == nil {
            headerView?.charName.text = self.episode?.name
            headerView?.leadingConstraintOfStackView.constant = 10
        } else if character == nil, episode == nil {
            headerView?.charName.text = self.location?.name
            headerView?.leadingConstraintOfStackView.constant = 10

        }
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView")
        guard section == 0 else { return 30 }
        return headerView?.frame.height ?? 100
    }

    func getImage(){
        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
            DispatchQueue.main.async {
                self.charImage = UIImage(data: data)
                self.tableView.reloadData()
            }
        }
    }



    @objc func addToFavorites(){
        if episode == nil, location == nil {
            CoreDataManager.shared.saveCharacter(char: self.character!)
        } else if character == nil, location == nil {
            CoreDataManager.shared.saveEpisode(episode: self.episode!)
        } else if character == nil, episode == nil {
            CoreDataManager.shared.saveLocation(location: self.location!)
        }
    }
}



