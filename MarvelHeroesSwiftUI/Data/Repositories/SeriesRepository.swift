import Foundation

final class SeriesRepository: SeriesRepositoryProtocol {
    private let network: SeriesNetworkProtocol
    
    init(network: SeriesNetworkProtocol = NetworkSeries()) {
        self.network = network
    }
    
    func getSeries(heroID: Int) async -> [SerieResult] {
        return await network.fetchSeries(heroID: heroID)
    }
}


// Mock
final class SeriesRepositoryMock: SeriesRepositoryProtocol {
    private let network: SeriesNetworkProtocol

    init(network: SeriesNetworkProtocol = NetworkSeriesMock()) {
        self.network = network
    }

    func getSeries(heroID: Int) async -> [SerieResult] {
        return await network.fetchSeries(heroID: heroID)
    }
}
