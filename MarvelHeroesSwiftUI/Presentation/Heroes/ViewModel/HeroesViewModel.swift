import Foundation


@Observable
final class HeroesViewModel {
    
    var heroesData = [Hero]() // Lista de héroes observable
    
    var state: StatusApp = .loading 
    
    var filterUI: String = ""  { // Observable para la búsqueda
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.filterUI.count > 1 { //establecemos aqui que el usuario tenga que introducir minimo 2 letras en la busqueda antes de que se realice otra peticion
                    Task {
                        await self.getHeroes(newSearch: self.filterUI)
                    }
                }
            }
        }
    }
    
    
    @ObservationIgnored
    private let useCaseHeroes: HeroesUseCaseProtocol // No observable, inyección de dependencias
    
    init(useCaseHeroes: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCaseHeroes = useCaseHeroes
        Task {
            await getHeroes()
        }
    }
    
    @MainActor
    func getHeroes(newSearch: String = "") async {
        
        let data = await useCaseHeroes.getHeroes(filter: newSearch)
        print("Datos recibidos: \(data)")
        if data.isEmpty { //si no hay datos que mostrar, ponemos el state en error.
            state = .error("Heroes not found")
        } else {
            heroesData = data
            state = .loaded
        }
    }
}
