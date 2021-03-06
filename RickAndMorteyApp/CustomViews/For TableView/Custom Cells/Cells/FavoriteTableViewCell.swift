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

    var character: Character?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configureForFavorite(with character: FavoritesCharacter?) {
        self.nameLabel?.text = character?.name
        if character?.status == "Alive" {
            self.statusLabel?.textColor = .systemGreen
        } else {
            self.statusLabel?.textColor = .systemRed
        }
        self.statusLabel?.text = "• \(character?.status ?? "")"

        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
            DispatchQueue.main.async {
                self.charImage?.image = UIImage(data: data)
            }
        }
    }

    func configureForCharacter(with character: Character?){
        self.nameLabel?.text = character?.name
        if character?.status == "Alive" {
            self.statusLabel?.textColor = .systemGreen
        } else {
            self.statusLabel?.textColor = .systemRed
        }
        self.statusLabel?.text = "• \(character?.status ?? "")"

        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
            DispatchQueue.main.async {
                self.charImage?.image = UIImage(data: data)
            }
        }
    }

}
