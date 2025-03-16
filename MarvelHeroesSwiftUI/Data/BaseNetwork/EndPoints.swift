import Foundation

//EndPoints for the Requests:
enum EndPoints: String {
    case heroes = "characters"
    static func series(for heroID: Int) -> String {
        return "characters/\(heroID)/series"
    }
}
