//
//  ReviewRepository.swift
//  CUUWorkshop
//
//  Created by Alejos on 6/26/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

class ReviewRepository {
    var query = ""
    let todoEndpoint: String = "https://api.nytimes.com/svc/movies/v2/reviews/search.json"
    
    var urlComponents : NSURLComponents {
        let components = NSURLComponents(string: todoEndpoint)!
        components.queryItems = [
            URLQueryItem(name: "api-key", value: "1e73df4e96b248d799a4cab2e82350fd"),
            URLQueryItem(name: "query", value: query)
        ]
        return components
    }
    var urlRequest: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("1e73df4e96b248d799a4cab2e82350fd", forHTTPHeaderField: "api-key")
        return request
    }
    
    func getReviews(query: String, completionHandler: @escaping ([String: Any]) -> ()) {
        self.query = query
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let dataResponse = data {
                let json = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let dictionary = json as? [String: Any] {
                    completionHandler(dictionary)
                }
            } else {
                print(error?.localizedDescription as Any)
                completionHandler([:])
            }
        }
        task.resume()
    }
}
