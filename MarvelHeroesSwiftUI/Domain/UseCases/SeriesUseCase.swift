import Foundation


final class SeriesUseCase: SeriesUseCaseProtocol {
    private let repository: SeriesRepositoryProtocol
    
    init(repository: SeriesRepositoryProtocol = SeriesRepository()) {
        self.repository = repository
    }
    
    func getSeries(heroID: Int) async -> [Serie] {
        return await repository.getSeries(heroID: heroID)
    }
}


// Mock
final class SeriesUseCaseMock: SeriesUseCaseProtocol {
    private let repository: SeriesRepositoryProtocol

    init(repository: SeriesRepositoryProtocol = SeriesRepositoryMock()) {
        self.repository = repository
    }

    func getSeries(heroID: Int) async -> [Serie] {
        return await repository.getSeries(heroID: heroID)
    }
}
