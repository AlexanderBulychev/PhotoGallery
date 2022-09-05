import Foundation

struct PhotoResponse: Codable {
    let totalItems: Int
    let itemsPerPage: Int
    let countOfPages: Int
    let data: [Photo]
}

struct Photo: Codable {
    let name: String
    let description: String
    let new: Bool
    let popular: Bool
    let image: ImageProperties
}

struct ImageProperties: Codable {
    let name: String
}
