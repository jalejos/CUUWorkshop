//
//  ViewController.swift
//  CUUWorkshop
//
//  Created by Alejos on 6/26/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    var reviewArray: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewService().getReviews(query: "") { (reviews) in
            self.reviewArray = reviews
            self.stepTwo()
        }

    }

    func stepTwo() {
        DispatchQueue.main.async {
            let review = self.reviewArray[0]
            self.imageView.image = review.image
            self.titleLabel.text = review.title
            self.authorLabel.text = review.author
            self.summaryLabel.text = review.summary
        }
        
    }

}

