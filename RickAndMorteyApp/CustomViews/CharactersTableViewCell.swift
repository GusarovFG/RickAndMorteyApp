//
//  CharactersTableViewCell.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 01.10.2021.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2

        }
    }

    // MARK: - Public methods
    func configure(with character: Character?) {
        nameLabel.text = character?.name
        if character?.status == "Alive" {
            statusLabel.tintColor = .green
        } else {
            statusLabel.tintColor = .red
        }
        statusLabel.text = "• \(character?.status ?? "")"

        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: data)
            }
        }
    }

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        
    }

}
