import Foundation

final class HeroesUseCase: HeroesUseCaseProtocol {
    let repository: HeroesRepositoryProtocol

    init(repository: HeroesRepositoryProtocol = HeroesRepository()) {
        self.repository = repository
    }

    func getHeroes(filter: String) async -> [HeroResult] {
        return await repository.getHeroes(filter: filter)
    }
}


// Mock
final class HeroesUseCaseMock: HeroesUseCaseProtocol {
    private let repository: HeroesRepositoryProtocol

    init(repository: HeroesRepositoryProtocol = HeroesRepositoryMock()) {
        self.repository = repository
    }

    func getHeroes(filter: String) async -> [HeroResult] {
        return await repository.getHeroes(filter: filter)
    }
}
