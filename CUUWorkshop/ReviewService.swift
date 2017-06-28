//
//  ReviewService.swift
//  CUUWorkshop
//
//  Created by Alejos on 6/26/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

class ReviewService {
    func getReviews(query: String, completionHandler: @escaping ([Review]) -> Void) {
        ReviewRepository().getReviews(query: query) { (dictionary) in
            var reviewArray : [Review] = []
            let array = dictionary["results"] as! [[String: Any]]
            for result in array {
                let review = Review(result)
                reviewArray.append(review)
            }
            completionHandler(reviewArray)
        }
    }
}
