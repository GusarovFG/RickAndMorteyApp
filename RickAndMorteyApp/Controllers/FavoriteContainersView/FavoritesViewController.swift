//
//  FavoritesViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 31.10.2021.
//

import UIKit


class FavoritesViewController: UIViewController {


    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var locationsView: UIView!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var charactersView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.selectedSegmentTintColor = .yellow

    }
    

    @IBAction func reloadDataBySegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.charactersView.isHidden = false
            self.locationsView.isHidden = true
            self.episodesView.isHidden = true

            
        case 1:
            self.locationsView.isHidden = false
            self.charactersView.isHidden = true
            self.episodesView.isHidden = true
        case 2:
            self.episodesView.isHidden = false
            self.charactersView.isHidden = true
            self.locationsView.isHidden = true

        default:
            break
        }

    }
}
