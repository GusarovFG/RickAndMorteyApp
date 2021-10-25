//
//  ViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 25.10.2021.
//

import UIKit

class PageViewController: UIPageViewController {

    let headers = ["About the app", "What is this?", "Who are you?", "Why did you build this?", "Technical stuff?", "Copyright?"]
    let descriptions = ["This app uses The Rick and Morty API", "The Rick and Morty API is a REST(ish) and GraphQL API based on the television show Rick and Morty. You will have access to about hundreds of characters, images, locations and episodes. The Rick and Morty API is filled with canonical information as seen on the TV show", "The developers of The Rick and Morty API are Axel Fuhrmann, a guy who likes to develop things and Talita, the \"Rick and Morty data scientist\" and hardcore fan", "Because we were really interested in the idea of writing an open source project and also because Rick and Morty is our favorite show at that moment, so why not?", "The Rick and Morty API uses Node and MongoDB to serve the API. All the data is formatted in json and the API is hosted on Digital Ocean and Netlify", "Rick and Morty is created by Justin Roiland and Dan Harmon for Adult Swim. The data and images are used without claim of ownership and belong to their respective owners. The Rick and Morty API is open source and uses a BSD license"]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self

        if let welcomeVC = showViewControllerAtIndex(0) {
            setViewControllers([welcomeVC], direction: .forward, animated: true, completion: nil)
        }

    }
    
    private func showViewControllerAtIndex(_ index: Int) -> WelcomeViewController? {

        guard let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else { return nil }
        guard index >= 0 else { return nil }
        guard index < headers.count else { return nil }
        welcomeVC.header = headers[index]
        welcomeVC.descriptionOfPage = descriptions[index]
        welcomeVC.currentPage = index
        welcomeVC.numberOfPage = headers.count

        return welcomeVC
    }
}

extension PageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var pageNumber = (viewController as! WelcomeViewController).currentPage
        pageNumber -= 1

        return showViewControllerAtIndex(pageNumber)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var pageNumber = (viewController as! WelcomeViewController).currentPage
        pageNumber += 1


        return showViewControllerAtIndex(pageNumber)

    }



}
