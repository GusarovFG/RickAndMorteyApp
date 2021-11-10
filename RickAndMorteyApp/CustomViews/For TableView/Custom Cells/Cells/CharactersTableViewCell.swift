//
//  CharactersTableViewCell.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 01.10.2021.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    var character: Character = Character(id: 0, name: "", status: "", species: "", gender: "", location: Location(name: "", type: "", dimension: "", residents: [], url: "", created: ""), image: "", episode: [], url: "", created: "")


    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView?.contentMode = .scaleAspectFit
            characterImageView?.layer.cornerRadius = (characterImageView?.frame.height ?? 0) / 2
        }
    }

    // MARK: - Public methods
    func configure(with character: Character?) {
        self.nameLabel?.text = character?.name
        if character?.status == "Alive" {
            self.statusLabel?.textColor = .systemGreen
        } else {
            self.statusLabel?.textColor = .systemRed
        }
        self.statusLabel?.text = "• \(character?.status ?? "")"

        ImageManager.shared.fetchImage(from: character?.image ?? "") { data, response in
            DispatchQueue.main.async {
                self.characterImageView?.image = UIImage(data: data)
            }
        }
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if CoreDataManager.shared.fetchCharacters().filter({$0.id == self.character.id}).isEmpty  {
            CoreDataManager.shared.saveCharacter(char: self.character)
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.favoriteButton.tintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)

        } else {
            guard let charForDelete = CoreDataManager.shared.fetchCharacters().filter({$0.id == self.character.id}).first else { return }
            CoreDataManager.shared.persistentContainer.viewContext.delete(charForDelete)
            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.favoriteButton.tintColor = .systemGray
        }

    }

}
