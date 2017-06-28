//
//  Review.swift
//  CUUWorkshop
//
//  Created by Alejos on 6/26/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import UIKit

class Review {
    var title: String = "Workshop"
    var author: String = "Alejos"
    var summary: String = "Hablando de swift"
    var image: UIImage? = nil
    
    init(_ dictionary: [String: Any]) {
        if let title = dictionary["display_title"] as? String{
            self.title = title
        }
        if let author = dictionary["byline"] as? String{
            self.author = author
        }
        if let summary = dictionary["summary_short"] as? String {
            self.summary = summary
        }
        guard let media = dictionary["multimedia"] as? [String: Any] else {
            return
        }
        guard let urlString = media["src"] as? String else {
            return
        }
        let image = try? UIImage(data: Data(contentsOf: URL(string: urlString)!))
        if let image = image {
            self.image = image
        }
    }
}
