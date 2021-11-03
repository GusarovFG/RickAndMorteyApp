//
//  StatisticViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 28.10.2021.
//
import GooglePlaces
import GoogleMaps
import UIKit

class StatisticViewController: UIViewController {

    @IBOutlet weak var hourHabel: UILabel?
    @IBOutlet weak var viewWithTimer: UIView!
    @IBOutlet weak var minuteLabel: UILabel?
    @IBOutlet weak var secondLabel: UILabel?
    @IBOutlet weak var timerStackView: UIStackView?





    var timer:Timer = Timer()
    var count: Int16 = 0
    var timerCounting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()


        startStopTimer()

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            timerStackView?.axis = .horizontal
        } else {
            timerStackView?.axis = .vertical
        }
    }

    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset time", message: "Do you want to reset time?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
        }))

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.timer.invalidate()
            self.count = 0
            let timeString = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.secondLabel?.text = timeString.2
            self.hourHabel?.text = timeString.0
            self.minuteLabel?.text = timeString.1
            self.timerCounting.toggle()
            self.startStopTimer()
        }))

        self.present(alert, animated: true, completion: nil)
    }

     func startStopTimer() {

        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
        } else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)

        }
    }

    @objc func timerCounter() {

        self.count += 1
        let time = secondsToHoursMinutesSeconds(seconds: Int(self.count))
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        secondLabel?.text = timeString.2
        hourHabel?.text = timeString.0
        minuteLabel?.text = timeString.1
    }

    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }

    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> (String, String, String) {
        let secondString = String(format: "%02d", seconds)
        let minuteString = String(format: "%02d", minutes)
        let hourString = String(format: "%02d", hours)
        return (hourString,minuteString,secondString)
    }




}
