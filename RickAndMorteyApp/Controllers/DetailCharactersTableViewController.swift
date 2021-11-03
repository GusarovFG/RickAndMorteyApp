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
    private var characterImage: UIImage?
    private var header: CustomHeader!
    private var charImage: UIImage?


    




    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        tableView.register(UINib(nibName: "DetailLocationAndEpisodeCell", bundle: nil), forCellReuseIdentifier: "DetailLocationAndEpisodeCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
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


        }   else if indexPath >= [2,0] {
            content.text = character?.episode[indexPath.row]
            print(indexPath)
            content.secondaryText = character?.episode[indexPath.row]
            cell.contentConfiguration = content
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
         if section == 1{
            title = "LOCATION"
        } else if section == 2{
            title = "EPISODES"
        }
        return title
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as? CustomHeader
        headerView?.favoriteButtonPressed.addTarget(self, action: #selector(qwe), for: .touchUpInside)
        headerView?.charImage.image = self.charImage
        headerView?.charName.text = self.character?.name
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
    @objc func qwe(){
        CoreDataManager.shared.insertInEntity(char: self.character!)
    }
}

