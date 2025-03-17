import Foundation


//MARK: Heroes' RepositoryClass
class HeroesRepository: HeroesRepositoryProtocol {
    private let network: HeroesNetworkProtocol

    init(network: HeroesNetworkProtocol = NetworkHeroes()) {
        self.network = network
    }

    func getHeroes() async -> [HeroResult] {
        return await network.fetchHeroes()
    }
}



//MARK: Mock for testing and previews
final class HeroesRepositoryMock: HeroesRepositoryProtocol {
    private let network: HeroesNetworkProtocol

    init(network: HeroesNetworkProtocol = NetworkHeroesMock()) {
        self.network = network
    }

    func getHeroes() async -> [HeroResult] {
        return await network.fetchHeroes()
    }
}
