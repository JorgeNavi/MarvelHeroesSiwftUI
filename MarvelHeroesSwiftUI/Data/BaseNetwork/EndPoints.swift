import Foundation

//MARK: EndPoints for the Requests:
enum EndPoints: String {
    case heroes = "characters"
    
    //func to give an heroId for the url
    static func series(for heroID: Int) -> String {
        return "characters/\(heroID)/series"
    }
}
