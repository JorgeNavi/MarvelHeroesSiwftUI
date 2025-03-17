
import Foundation

protocol HeroesUseCaseProtocol {

    func getHeroes() async -> [HeroResult]
}
