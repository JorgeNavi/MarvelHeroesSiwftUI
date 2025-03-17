import Foundation


@Observable
final class HeroesViewModel {
    
    var heroesData = [HeroResult]() // Lista de héroes observable
    
    var state: StatusApp = .loading 
    
    var filterUI: String = "" {
        didSet {
            guard filterUI != oldValue, !filterUI.isEmpty, filterUI.count > 1 else { return } // Evita llamadas innecesarias
            Task {
                print("🟠 Ejecutando getHeroes() desde filterUI con filtro: \(filterUI)")
                await self.getHeroes(newSearch: self.filterUI)
            }
        }
    }
    
    
    @ObservationIgnored
    private let useCaseHeroes: HeroesUseCaseProtocol // No observable, inyección de dependencias
    
    init(useCaseHeroes: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCaseHeroes = useCaseHeroes
        print("🔵 Inicializando HeroesViewModel y llamando a getHeroes()")
        Task {
            await getHeroes()
        }
    }
    
    @MainActor
    func getHeroes(newSearch: String = "") async {
        print("🟢 getHeroes() ejecutado con filtro: \(newSearch)")
        
        let data = await useCaseHeroes.getHeroes(filter: newSearch)
        print("✅ Datos recibidos: \(data.count) héroes")
        if data.isEmpty { //si no hay datos que mostrar, ponemos el state en error.
            state = .error("Heroes not found")
        } else {
            heroesData = data
            state = .loaded
        }
    }
}
