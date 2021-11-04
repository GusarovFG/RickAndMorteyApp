//
//  TimerManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 04.11.2021.
//

import Foundation
import UIKit

class TimerManager {

    static let shared = TimerManager()

    var hourLabel = ""
    var minuteLabel = ""
    var secondLabel = ""

    private var timer:Timer = Timer()
    private var count: Int16 = 0
    private var timerCounting: Bool = false

    private init() {}

    func startStopTimer() {

        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
        } else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)

        }
    }

    @objc private func timerCounter() {

        self.count += 1
        let time = secondsToHoursMinutesSeconds(seconds: Int(self.count))
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        self.secondLabel = timeString.2
        self.hourLabel = timeString.0
        self.minuteLabel = timeString.1
        print(self.count)
    }

    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }

    private func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> (String, String, String) {
        let secondString = String(format: "%02d", seconds)
        let minuteString = String(format: "%02d", minutes)
        let hourString = String(format: "%02d", hours)
        return (hourString,minuteString,secondString)
    }

    func resetTimer(controller: UIViewController){
        let alert = UIAlertController(title: "Reset time", message: "Do you want to reset time?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
        }))

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.timer.invalidate()
            self.count = 0
            let timeString = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.secondLabel = timeString.2
            self.hourLabel = timeString.0
            self.minuteLabel = timeString.1
            self.timerCounting.toggle()
            self.startStopTimer()
        }))

        controller.present(alert, animated: true)
    }
}
