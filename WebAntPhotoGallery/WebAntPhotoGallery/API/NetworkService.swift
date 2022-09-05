import Foundation

//private let url = "https://iiko.biz:9900"
//private let api = "/api/0"
//private let user_id = "Yokoso42@mail.ru"
//private let user_secret = "Fomenko0705"
//private let organizationId = "7a3f8b2a-d38f-11e9-80dd-d8d385655247"
//
//static var shared = iikoAPI()
//private init() {}

// https://gallery.prod1.webant.ru/api/photos?new=true

class WebAntAPI {
    static let shared = WebAntAPI()

    private let url = "https://gallery.prod1.webant.ru"
    private let api = "api/photos"

    private init() {}

    func getPhotos() {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        guard let url = URL(string: "https://gallery.prod1.webant.ru/api/photos?new=true") else { return }
        session.dataTask(with: url) { data, response, error in
            if error == nil, let data = data {
                let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: data)
                print("Photos: \(photoResponse)")
            }
            else {
                print("Error: \(error?.localizedDescription ?? "no error description")")
            }
        }.resume()
    }

}
