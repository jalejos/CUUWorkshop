//
//  ViewController.swift
//  CUUWorkshop
//
//  Created by Alejos on 6/26/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var reviewArray: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewService().getReviews(query: "") { (reviews) in
            self.reviewArray = reviews
            self.stepTwo()
        }

    }

    func stepTwo() {
        print(self.reviewArray[0].title)
    }
}

