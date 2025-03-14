import Foundation

class HeroesRepository: HeroesRepositoryProtocol {
    private let network: HeroesNetworkProtocol

    init(network: HeroesNetworkProtocol = NetworkHeroes()) {
        self.network = network
    }

    func getHeroes(filter: String) async -> [Hero] {
        return await network.fetchHeroes(filter: filter)
    }
}
