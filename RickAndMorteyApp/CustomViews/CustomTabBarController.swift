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

        let tab3 = UIViewController()
        tab3.view.backgroundColor = .yellow
        tab3.tabBarItem = UITabBarItem(title: "Second", image: nil, selectedImage: nil)

        let viewControllers = [
            charactersVC,
            tab3
        ]

        self.setViewControllers(viewControllers, animated: false)
    }

    private func addGestureRecognized() {
        if let customTabBar = tabBar as? CustomTabBar {
            customTabBar.middleButton.addTarget(self, action: #selector(middleButtonDidTap), for: .touchUpInside)
        }
    }

    @objc func middleButtonDidTap(sender: UIButton) {
        let LoginsVC = self.storyboard!.instantiateViewController(identifier: "LoginsViewController") as! LoginViewController
        LoginsVC.modalPresentationStyle = .fullScreen
        self.present(LoginsVC, animated: true)
    }

}

