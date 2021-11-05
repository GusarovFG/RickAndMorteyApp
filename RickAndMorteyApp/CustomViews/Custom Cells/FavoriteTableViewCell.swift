//
//  FavoriteTableViewCell.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 01.11.2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!


    func configure(with character: FavoritesCharacter?) {
        nameLabel?.text = character?.name
        if character?.status == "Alive" {
            statusLabel?.textColor = .systemGreen
        } else {
            statusLabel?.textColor = .systemRed
        }
        statusLabel?.text = "• \(character?.status ?? "")"

        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
            DispatchQueue.main.async {
                self.charImage?.image = UIImage(data: data)
            }
        }
    }

}
