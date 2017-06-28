# CUUWorkshop
Hanging in the Playground

## Step 1
Add anywhere on the playground:

```
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
```

### Step 2 
Add anywhere on the playground:
```
class Review {
    var title: String
    var author: String
    var summary: String
    var image: UIImage?
    
    init(_ dictionary: [String: Any]) {
    
    }
}
```

### Step 2.5
Add this after the lines added in the exercise:
```
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
```

### Step 3
Add anywhere on the playground:
```
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
    
    func getReviews() {
    
    }
}
```

### Step 4
Add anywhere on the playground:
```
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
```

