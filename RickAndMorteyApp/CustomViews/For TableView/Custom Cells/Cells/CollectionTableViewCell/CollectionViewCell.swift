//
//  CollectionViewCell.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!

    func setupNameLabel(name: String) {
        self.name.text = name
    }

    func fetchImage(url: String) {
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data)
            }
        }
    }
}
