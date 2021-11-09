//
//  NewLoginViewViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 25.10.2021.
//

import UIKit

class WelcomeViewController: UIViewController, UITextViewDelegate {

    var header = ""
    var descriptionOfPage = ""
    var currentPage = 0
    var numberOfPage = 0
    let userDefaultsManager = UserDefaults.standard


    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var currentPageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerLabel.text = header
        self.descriptionTextView.text = descriptionOfPage
        self.currentPageControl.numberOfPages = numberOfPage
        self.currentPageControl.currentPage = currentPage

        updateTextView()
    }

    private func updateTextView() {
        switch self.currentPage {
        case 0:
            let text = self.descriptionTextView.text ?? ""

            let path = textsForHyperLinks.one.rawValue

            let attributeString = NSAttributedString.makeHyperlink(for: path, in: text, as: "The Rick and Morty API")

            let font = descriptionTextView.font
            descriptionTextView.attributedText = attributeString
            descriptionTextView.font = font
        case 1:
            let text = descriptionTextView.text ?? ""

            let path = textsForHyperLinks.two.rawValue

            let attributeString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Rick and Morty")

            let font = descriptionTextView.font
            descriptionTextView.attributedText = attributeString
            descriptionTextView.font = font
        case 2:
            let text = descriptionTextView.text ?? ""
            let attributes = NSMutableAttributedString()

            let pathOne = textsForHyperLinks.three.rawValue
            let pathTwo = textsForHyperLinks.four.rawValue

            let attributeStringOne = NSAttributedString.makeHyperlink(for: pathOne, in: text, as: "Axel Fuhrmann")
            let attributeStringTwo = NSAttributedString.makeHyperlink(for: pathTwo, in: text, as: "Talita")

            attributes.append(attributeStringOne)
            attributes.append(attributeStringTwo)

            let font = descriptionTextView.font
            self.descriptionTextView.attributedText = attributes
            self.descriptionTextView.font = font
        case 4:
            let text = self.descriptionTextView.text ?? ""
            let attributes = NSMutableAttributedString()

            let pathOne = textsForHyperLinks.five.rawValue
            let pathTwo = textsForHyperLinks.six.rawValue
            let pathThree = textsForHyperLinks.seven.rawValue
            let pathFour = textsForHyperLinks.eight.rawValue
            let pathSix = textsForHyperLinks.nine.rawValue

            let attributeStringOne = NSAttributedString.makeHyperlink(for: pathOne, in: text, as: "Node")
            let attributeStringTwo = NSAttributedString.makeHyperlink(for: pathTwo, in: text, as: "MongoDB")
            let attributeStringThree = NSAttributedString.makeHyperlink(for: pathThree, in: text, as: "json")
            let attributeStringFour = NSAttributedString.makeHyperlink(for: pathFour, in: text, as: "Digital Ocean")
            let attributeStringFive = NSAttributedString.makeHyperlink(for: pathSix, in: text, as: "Netlify")

            attributes.append(attributeStringOne)
            attributes.append(attributeStringTwo)
            attributes.append(attributeStringThree)
            attributes.append(attributeStringFour)
            attributes.append(attributeStringFive)

            let font = descriptionTextView.font
            self.descriptionTextView.attributedText = attributes
            self.descriptionTextView.font = font
        case 5:
            let text = self.descriptionTextView.text ?? ""

            let path = textsForHyperLinks.ten.rawValue

            let attributeString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Adult Swim")

            let font = self.descriptionTextView.font
            self.descriptionTextView.attributedText = attributeString
            self.descriptionTextView.font = font
        default:
            break
        }
    }


    @IBAction func skipButtonPressed(_ sender: UIButton) {
        self.userDefaultsManager.setValue(true, forKey: "Greeting")
        self.dismiss(animated: true)
    }


}
