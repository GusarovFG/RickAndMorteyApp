//
//  GreetingsScreenViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 20.09.2021.
//

import UIKit

class GreetingsScreenViewController: UIViewController {

    let images = [UIImage(named: "rick"), UIImage(named: "asd"), UIImage(named: "mortey")]

    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageScrollPageController: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!



    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.imageScrollView.delegate = self
        self.imageScrollPageController.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        self.imageScrollPageController.currentPage = 0
        self.imageScrollPageController.numberOfPages = images.count
        configurateScrollView(self.imageScrollView)

        

        // Do any additional setup after loading the view.
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
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension GreetingsScreenViewController: UIScrollViewDelegate {


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageScrollPageController.currentPage = Int(imageScrollView.contentOffset.x / imageScrollView.frame.size.width)
    }
}
