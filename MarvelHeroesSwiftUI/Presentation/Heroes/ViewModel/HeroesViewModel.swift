import Foundation

//MARK: Heroes' ViewModel
@Observable
final class HeroesViewModel {
    
    var heroesData = [HeroResult]()
    var state: StatusApp = .loading
    
    @ObservationIgnored
    private let useCaseHeroes: HeroesUseCaseProtocol
    
    init(useCaseHeroes: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCaseHeroes = useCaseHeroes
        NSLog("Init HeroesViewModel and calling getHeroes()")
        Task {
            await getHeroes()
        }
    }
    
    @MainActor
    func getHeroes() async {
        let data = await useCaseHeroes.getHeroes()
        NSLog("Heroes recieved: \(data.count) heroes")
        if data.isEmpty {
            state = .error("Heroes not found")
        } else {
            heroesData = data
            state = .loaded
        }
    }
}
