//
//  ContainersViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 04.11.2021.
//

import UIKit

class ContainersViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var mapContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapContainer.isHidden = true
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.title = "Statistic"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func segmentedControlSwitched(_ sender: UISegmentedControl) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.timerContainer.isHidden = false
            self.mapContainer.isHidden = true
        case 1:
            self.timerContainer.isHidden = true
            DispatchQueue.main.async {
                self.mapContainer.isHidden = false
            }
        default:
            break
        }
    }
}
