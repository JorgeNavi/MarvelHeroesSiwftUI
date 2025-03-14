import Foundation

final class HeroesUseCase: HeroesUseCaseProtocol {
    let repository: HeroesRepositoryProtocol

    init(repository: HeroesRepositoryProtocol = HeroesRepository()) {
        self.repository = repository
    }

    func getHeroes(filter: String) async -> [Hero] {
        return await repository.getHeroes(filter: filter)
    }
}
