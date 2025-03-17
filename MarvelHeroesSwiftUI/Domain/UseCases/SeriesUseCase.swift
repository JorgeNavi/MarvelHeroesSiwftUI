import Foundation

//MARK: Series' UseCase
final class SeriesUseCase: SeriesUseCaseProtocol {
    private let repository: SeriesRepositoryProtocol
    
    init(repository: SeriesRepositoryProtocol = SeriesRepository()) {
        self.repository = repository
    }
    
    func getSeries(heroID: Int) async -> [SerieResult] {
        return await repository.getSeries(heroID: heroID)
    }
}


//MARK: Mock for testing and previews
final class SeriesUseCaseMock: SeriesUseCaseProtocol {
    private let repository: SeriesRepositoryProtocol

    init(repository: SeriesRepositoryProtocol = SeriesRepositoryMock()) {
        self.repository = repository
    }

    func getSeries(heroID: Int) async -> [SerieResult] {
        return await repository.getSeries(heroID: heroID)
    }
}
