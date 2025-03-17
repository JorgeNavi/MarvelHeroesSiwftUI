import Foundation

//MARK: Series' RepositoryClass
final class SeriesRepository: SeriesRepositoryProtocol {
    private let network: SeriesNetworkProtocol
    
    init(network: SeriesNetworkProtocol = NetworkSeries()) {
        self.network = network
    }
    
    func getSeries(heroID: Int) async -> [SerieResult] {
        return await network.fetchSeries(heroID: heroID)
    }
}


//MARK: Mock for testing and previews
final class SeriesRepositoryMock: SeriesRepositoryProtocol {
    private let network: SeriesNetworkProtocol

    init(network: SeriesNetworkProtocol = NetworkSeriesMock()) {
        self.network = network
    }

    func getSeries(heroID: Int) async -> [SerieResult] {
        return await network.fetchSeries(heroID: heroID)
    }
}
