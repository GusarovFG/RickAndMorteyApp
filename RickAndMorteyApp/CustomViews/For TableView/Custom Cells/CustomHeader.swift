//
//  CustomHeader.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 15.10.2021.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var favoriteButtonPressed: UIButton!
    @IBOutlet weak var leadingConstraintOfStackView: NSLayoutConstraint!
    







    @IBAction func addToFavorites(_ sender: UIButton) {

        if sender.titleLabel?.text == "Add to Favorites" {
            sender.setTitle("In Favorites", for: .normal)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.favoriteButtonPressed.tintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        } else {
            sender.setTitle("Add to Favorites", for: .normal)
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            self.favoriteButtonPressed.tintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        }

    }
}
