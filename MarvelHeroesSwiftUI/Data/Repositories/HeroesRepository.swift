import Foundation


//MARK: Heroes' RepositoryClass
class HeroesRepository: HeroesRepositoryProtocol {
    private let network: HeroesNetworkProtocol

    init(network: HeroesNetworkProtocol = NetworkHeroes()) {
        self.network = network
    }

    func getHeroes(filter: String) async -> [HeroResult] {
        return await network.fetchHeroes(filter: filter)
    }
}



//MARK: Mock for testing and previews
final class HeroesRepositoryMock: HeroesRepositoryProtocol {
    private let network: HeroesNetworkProtocol

    init(network: HeroesNetworkProtocol = NetworkHeroesMock()) {
        self.network = network
    }

    func getHeroes(filter: String) async -> [HeroResult] {
        return await network.fetchHeroes(filter: filter)
    }
}
