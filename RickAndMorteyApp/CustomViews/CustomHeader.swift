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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var favoriteButtonPressed: UIButton!
}
