//
//  StatisticViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 28.10.2021.
//

import UIKit

class StatisticViewController: UIViewController {

    

    @IBOutlet weak var viewWithTimer: UIView!
    @IBOutlet weak var hourHabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var timerStackView: UIStackView!


    var timer:Timer = Timer()
    var timerCounting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        startStopTimer()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.8392156863, alpha: 1)
        self.title = "Statistic"
        self.navigationController?.navigationBar.tintColor = .white
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.timerStackView?.axis = .horizontal
        } else {
            self.timerStackView?.axis = .vertical
        }
    }

    @IBAction func resetTapped(_ sender: Any) {
        TimerManager.shared.resetTimer(controller: self)
    }

    func startStopTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }

    @objc func timerCounter() {

            self.secondLabel?.text = TimerManager.shared.secondLabel
            self.minuteLabel?.text = TimerManager.shared.minuteLabel
            self.hourHabel?.text = TimerManager.shared.hourLabel
    }
}
