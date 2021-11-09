//
//  CollectionViewTableViewCell.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell{

    var characters: [Character] = []
    var name = "Name"
    var image = UIImageView()

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collection")
        self.collectionView.reloadData()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCharacter(characte: [Character]) {
        self.characters = characte
    }

}
extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionViewCell
        cell.setupNameLabel(name: self.name )
        cell.image = self.image
        return cell
    }   


}
