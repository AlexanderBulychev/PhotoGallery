import Foundation

enum ApiType {
    case getNewPhotos
    case getPopularPhotos

    var baseURL: URL {
        URL(string: "https://gallery.prod1.webant.ru/api/photos")!
    }

    var path: String {
        switch self {
        case .getNewPhotos: return "new=true"
        case .getPopularPhotos: return "popular=true"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        return URLRequest(url: url)
    }
}

class WebAntAPIManager {
    static let shared = WebAntAPIManager()

    func getNewPhotos(completion: @escaping ([Photo]) -> Void) {
        let request = ApiType.getNewPhotos.request

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: data)
                guard let photos = photoResponse?.data else { return completion([])}
                completion(photos)
            } else {
                completion([])
            }
        }.resume()
    }

    func getPopularPhotos(completion: @escaping ([Photo]) -> Void) {
        let request = ApiType.getPopularPhotos.request

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: data)
                guard let photos = photoResponse?.data else { return completion([])}
                completion(photos)
            } else {
                completion([])
            }
        }.resume()
    }
}


enum GetPhotosResult {
    case success(photos: [Photo])
    case failure(error: Error)
}

class WebAntAPI {
    static let shared = WebAntAPI()

    private let url = "https://gallery.prod1.webant.ru"
    private let api = "api/photos"

    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared

    private init() {}

    func getPhotos(completion: @escaping (GetPhotosResult) -> Void) {
        guard let url = URL(string: "https://gallery.prod1.webant.ru/api/photos?new=true") else { return }
        session.dataTask(with: url) { data, response, error in
            var result: GetPhotosResult

            if error == nil, let data = data {
                guard let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: data) else { return }
                result = .success(photos: photoResponse.data)
            }
            else {
                result = .failure(error: error!)
            }
            completion(result)
        }.resume()
    }

}
