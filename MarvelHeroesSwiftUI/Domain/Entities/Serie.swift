// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serie = try? JSONDecoder().decode(Serie.self, from: jsonData)

import Foundation

// MARK: - Serie
struct Serie: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SerieDataClass
}

// MARK: - DataClass
struct SerieDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [SerieResult]
}

// MARK: - Result
struct SerieResult: Codable {
    let id: Int
    let title: String
    let description: String?
    let resourceURI: String
    let urls: [SerieURLElement]
    let startYear, endYear: Int
    let rating, type: String?
    let modified: Date
    let thumbnail: SerieThumbnail
    let creators: SerieCreators
    let characters: SerieCharacters
    let stories: SerieStories
    let comics, events: SerieCharacters
    let next, previous: SerieNext?
}

// MARK: - Characters
struct SerieCharacters: Codable {
    let available: Int
    let collectionURI: String
    let items: [SerieNext]?
    let returned: Int
}

// MARK: - Next
struct SerieNext: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct SerieCreators: Codable {
    let available: Int
    let collectionURI: String
    let items: [SerieCreatorsItem]?
    let returned: Int
}

// MARK: - CreatorsItem
struct SerieCreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - Stories
struct SerieStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [SerieStoriesItem]?
    let returned: Int
}

// MARK: - StoriesItem
struct SerieStoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: SerieTypeEnum
}

enum SerieTypeEnum: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct SerieThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct SerieURLElement: Codable {
    let type: String
    let url: String
}

//Para facilitar el acceso a la imagen de la serie
extension SerieResult {
    var photo: String {
        return "\(thumbnail.path).\(thumbnail.thumbnailExtension)"
    }
}
