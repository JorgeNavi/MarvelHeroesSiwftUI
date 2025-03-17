import Foundation

protocol HeroesRepositoryProtocol {
    func getHeroes() async -> [HeroResult]
}
