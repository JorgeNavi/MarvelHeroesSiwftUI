import Foundation

// MARK: - Serie
struct Serie: Codable {
    let id: Int
    let title: String
    let description: JSONNull?
    let resourceURI: String
    let urls: [URLElement]
    let startYear, endYear: Int
    let rating, type: String
    let modified: Date
    let thumbnail: SerieThumbnail
    let creators, characters, stories, comics: Characters
    let events: Characters
    let next, previous: JSONNull?
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Item]
    let returned: Int
}

// MARK: - Item
struct Item: Codable {
    let resourceURI: String
    let name: String
    let role, type: String?
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
struct URLElement: Codable {
    let type: String
    let url: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
