//
//  CustomTabBarController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 05.10.2021.
//

import UIKit



class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addTabs()
        addGestureRecognized()
    }

    private func addTabs() {

        let charactersVC = self.storyboard!.instantiateViewController(identifier: "charactersNavi") as! UINavigationController
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "Character"), selectedImage: nil)

        let locationVC = UIViewController()
        locationVC.view.backgroundColor = .yellow
        locationVC.tabBarItem = UITabBarItem(title: "Location", image: UIImage(named: "Location"), selectedImage: nil)

        let statisticVC = self.storyboard!.instantiateViewController(identifier: "statistic") as! StatisticViewController
        statisticVC.tabBarItem = UITabBarItem(title: "Statistic", image: UIImage(named: "Statistic"), selectedImage: nil)
        statisticVC.tabBarItem.badgeColor = .yellow

        let episidesVC = UIViewController()
        episidesVC.view.backgroundColor = .yellow
        episidesVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(named: "Episodes"), selectedImage: nil)

        let viewControllers = [charactersVC, locationVC, statisticVC, episidesVC]


        self.setViewControllers(viewControllers, animated: false)
    }

    private func addGestureRecognized() {
        if let customTabBar = tabBar as? CustomTabBar {
            customTabBar.middleButton.addTarget(self, action: #selector(middleButtonDidTap), for: .touchUpInside)
        }
    }

    @objc func middleButtonDidTap(sender: UIButton) {
        sender.tintColor = .yellow
        let LoginsVC = self.storyboard!.instantiateViewController(identifier: "LoginsViewController") as! LoginViewController
        LoginsVC.modalPresentationStyle = .fullScreen
        self.present(LoginsVC, animated: true)
    }

}

