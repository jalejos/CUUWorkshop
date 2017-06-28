//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Hello, playground"
let double = 2.5

let jsonDummy: [String: Any] =
    [
        "display_title": "Baby Driver",
        "byline": "MANOHLA DARGIS",
        "summary_short": "Burning rubber and hot licks help propel this action movie about a getaway driver named Baby, played by Ansel Elgort. Edgar Wright directed.",
        "multimedia": [
            "src": "https://static01.nyt.com/images/2017/06/28/arts/28BABYDRIVE/28BABYDRIVE-mediumThreeByTwo210-v2.jpg",
            "width": 210,
            "height": 140
        ]
]


class Review {
    var title: String = "CUUWorkshop"
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


func startApplication() {
    ReviewService().getReviews(query: "") { (reviews) in
        for review in reviews {
            print(review.title)
        }
    }
}
startApplication()

let review = Review(jsonDummy)

