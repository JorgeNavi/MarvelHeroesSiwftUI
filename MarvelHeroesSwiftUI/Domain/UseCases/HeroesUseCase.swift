import Foundation

//MARK: Heroes' UseCase
final class HeroesUseCase: HeroesUseCaseProtocol {
    let repository: HeroesRepositoryProtocol

    init(repository: HeroesRepositoryProtocol = HeroesRepository()) {
        self.repository = repository
    }

    func getHeroes() async -> [HeroResult] {
        return await repository.getHeroes()
    }
}


//MARK: Mock for testing and previews
final class HeroesUseCaseMock: HeroesUseCaseProtocol {
    private let repository: HeroesRepositoryProtocol

    init(repository: HeroesRepositoryProtocol = HeroesRepositoryMock()) {
        self.repository = repository
    }

    func getHeroes() async -> [HeroResult] {
        return await repository.getHeroes()
    }
}
