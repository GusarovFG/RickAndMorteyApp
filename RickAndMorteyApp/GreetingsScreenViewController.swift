//
//  GreetingsScreenViewController.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 20.09.2021.
//

import UIKit

class GreetingsScreenViewController: UIViewController {

    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageScrollPageController: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!



    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateScrollView()

        // Do any additional setup after loading the view.
    }

    private func configurateScrollView() {
        let images = [UIImage(named: "rick"), UIImage(named: "asd"), UIImage(named: "mortey")]
        var imageViewRect = self.imageScrollView.bounds
        self.imageScrollView.isPagingEnabled = true
        self.imageScrollView.indicatorStyle = .white

        self.imageScrollView.contentSize = CGSize(width: self.imageScrollView.frame.size.width * CGFloat(images.count), height: self.imageScrollView.frame.size.height)

        for x in 0...images.count - 1{
            let imageView = UIImageView(frame: imageViewRect)
            imageView.image = images[x]
            imageViewRect.origin.x += imageView.frame.size.width
            self.imageScrollView.addSubview(imageView)
        }

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
