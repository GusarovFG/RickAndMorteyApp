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
        mapContainer.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func segmentedControlSwitched(_ sender: UISegmentedControl) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            timerContainer.isHidden = false
            mapContainer.isHidden = true
        case 1:
            timerContainer.isHidden = true
            mapContainer.isHidden = false
        default:
            break
        }
    }
}
