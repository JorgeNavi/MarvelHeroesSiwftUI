
import Foundation

protocol SeriesUseCaseProtocol {
    
    func getSeries(heroID: Int) async -> [SerieResult]
}
