
import Foundation

// MARK: - Hero
struct Hero: Codable, Identifiable {
    let id: Int
    let name, description: String
    let modified: String
    let thumbnail: HeroThumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [HeroURLElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

//Para facilitar el acceso a la imagen del heroe
extension Hero {
    var photo: String {
        return "\(thumbnail.path).\(thumbnail.thumbnailExtension)"
    }
}

// MARK: - HeroResponse
struct HeroResponse: Codable {
    let code: Int
    let status: String
    let data: HeroData
}

// MARK: - HeroData
struct HeroData: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Hero]
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct HeroThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct HeroURLElement: Codable {
    let type: String
    let url: String
}
