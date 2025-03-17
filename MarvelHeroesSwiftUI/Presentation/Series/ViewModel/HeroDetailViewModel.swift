import Foundation


//MARK: HeroesDetail's ViewModel
@Observable
final class HeroDetailViewModel {
    let hero: HeroResult
    var series: [SerieResult] = []
    var state: StatusApp = .loading
    
    private let useCaseSeries: SeriesUseCaseProtocol
    
    init(hero: HeroResult, useCaseSeries: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.hero = hero
        self.useCaseSeries = useCaseSeries
    }
    
    @MainActor
    func getSeries(heroID: Int) async {
        let data = await useCaseSeries.getSeries(heroID: hero.id)
        if data.isEmpty {
            state = .error("No TVShows found")
        } else {
            series = data
            state = .loaded
        }
    }
}
