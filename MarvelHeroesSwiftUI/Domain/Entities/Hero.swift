
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hero = try? JSONDecoder().decode(Hero.self, from: jsonData)

import Foundation

// MARK: - Hero
struct Hero: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: HeroDataClass
}

// MARK: - DataClass
struct HeroDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [HeroResult]
}

// MARK: - Result
struct HeroResult: Codable, Identifiable {
    let id: Int
    let name, description: String
    let modified: Date
    let thumbnail: HeroThumbnail
    let resourceURI: String
    let comics, series: HeroComics
    let stories: HeroStories
    let events: HeroComics
    let urls: [HeroURLElement]
}
 

// MARK: - Comics
struct HeroComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [HeroComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct HeroComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct HeroStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [HeroStoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct HeroStoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: HeroItemType
}

enum HeroItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case pinup = "pinup"
}

// MARK: - Thumbnail
struct HeroThumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElement
struct HeroURLElement: Codable {
    let type: HeroURLType
    let url: String
}

enum HeroURLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

//Para facilitar el acceso a la imagen del heroe
extension HeroResult {
    var photo: String {
        return "\(thumbnail.path).\(thumbnail.thumbnailExtension)"
    }
}

