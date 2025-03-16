import Foundation

protocol SeriesRepositoryProtocol {
    
    func getSeries(heroID: Int) async -> [SerieResult]
}

