
import Foundation

protocol HeroesUseCaseProtocol {

    func getHeroes(filter: String) async -> [Hero]
}
