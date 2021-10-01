//
//  GreetingsScreenViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 20.09.2021.
//

import UIKit

class GreetingsScreenViewController: UIViewController {

    let images = [UIImage(named: "rick"), UIImage(named: "asd"), UIImage(named: "mortey")]
    let userDefaultsManager = UserDefaults.standard
    

    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageScrollPageController: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()


        imageScrollPageController.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        imageScrollPageController.currentPage = 0
        imageScrollPageController.numberOfPages = images.count

        imageScrollView.delegate = self
        configurateScrollView(self.imageScrollView)

        skipButton.isEnabled = false

    }

    private func configurateScrollView(_ scrollView: UIScrollView) {

        var imageViewRect = scrollView.bounds
        scrollView.isPagingEnabled = true
        scrollView.contentMode = .scaleToFill
        scrollView.indicatorStyle = .white

        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)

        for x in 0...images.count - 1{
            let imageView = UIImageView(frame: imageViewRect)
            imageView.image = images[x]
            imageViewRect.origin.x += imageView.frame.size.width
            scrollView.addSubview(imageView)

        }
    }

    @objc private func pageControlDidChange (_ sender: UIPageControl) {
        let current = sender.currentPage
        imageScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }

    @IBAction func skipButtonPressed(_ sender: Any) {

        userDefaultsManager.set(true, forKey: "Greeting")

        let vc = self.storyboard?.instantiateViewController(identifier: "LoginsViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve

        self.present(vc, animated: true)
        }
}

extension GreetingsScreenViewController: UIScrollViewDelegate {


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageScrollPageController.currentPage = Int(imageScrollView.contentOffset.x / imageScrollView.frame.size.width)
        if imageScrollPageController.currentPage == 2 {
            skipButton.isEnabled = true
        }

    }
}
