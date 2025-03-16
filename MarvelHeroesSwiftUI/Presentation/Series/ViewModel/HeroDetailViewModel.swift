import Foundation

@Observable
final class HeroDetailViewModel {
    let hero: HeroResult
    var series: [SerieResult] = []
    var state: StatusApp = .loading
    
    private let useCaseSeries: SeriesUseCaseProtocol
    
    init(hero: HeroResult, useCaseSeries: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.hero = hero
        self.useCaseSeries = useCaseSeries
        
        Task {
            await getSeries()
        }
    }
    
    @MainActor
    func getSeries() async {
        let data = await useCaseSeries.getSeries(heroID: hero.id)
        if data.isEmpty {
            state = .error("No series found")
        } else {
            series = data
            state = .loaded
        }
    }
}
