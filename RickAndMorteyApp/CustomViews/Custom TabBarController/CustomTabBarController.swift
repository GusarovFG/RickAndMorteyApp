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
        
        self.tabBar.selectedImageTintColor = .yellow
    }

    private func addTabs() {

        let charactersVC = self.storyboard!.instantiateViewController(identifier: "charactersNavi") as! UINavigationController
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "Character"), selectedImage: nil)

        let locationVC = self.storyboard!.instantiateViewController(identifier: "locationsNavi") as! UINavigationController
        locationVC.tabBarItem = UITabBarItem(title: "Location", image: UIImage(named: "Location"), selectedImage: nil)

        let favoritesVC = self.storyboard?.instantiateViewController(withIdentifier: "favorits") as! UINavigationController

        let statisticVC = self.storyboard!.instantiateViewController(identifier: "statistics") as! UINavigationController
        statisticVC.tabBarItem = UITabBarItem(title: "Statistic", image: UIImage(named: "Statistic"), selectedImage: nil)

        let episidesVC = self.storyboard?.instantiateViewController(withIdentifier: "episodes") as! UINavigationController
        episidesVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(named: "Episodes"), selectedImage: nil)


        let viewControllers = [charactersVC, locationVC, favoritesVC, statisticVC, episidesVC]


        self.setViewControllers(viewControllers, animated: false)
    }

    private func addGestureRecognized() {
        if let customTabBar = tabBar as? CustomTabBar {
            customTabBar.middleButton.addTarget(self, action: #selector(middleButtonDidTap), for: .touchUpInside)
        }
    }

    @objc func middleButtonDidTap(sender: UIButton) {
        sender.imageView?.tintColor = .yellow
        self.selectedIndex = 2

    }

}

