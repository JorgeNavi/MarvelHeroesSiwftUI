import Foundation
import Testing
import SwiftUI

@testable import MarvelHeroesSwiftUI

struct HeroesViewModelTests {

    @Suite("ViewModel Testing") struct ViewModelTest {
        

            @Test("HeroesViewModel carga héroes correctamente")
            func heroesViewModelFetchTest() async throws {
                
                let mockUseCase = HeroesUseCaseMock()
                let viewModel = HeroesViewModel(useCaseHeroes: mockUseCase)

                await viewModel.getHeroes()

                #expect(viewModel.heroesData.count == 2)
                #expect(viewModel.state == .loaded)
            }


            @Test("HeroesViewModel cambia a estado de error si no hay héroes")
            func heroesViewModelEmptyStateTest() async throws {
                
                let emptyUseCase = HeroesUseCaseEmptyMock()
                let viewModel = HeroesViewModel(useCaseHeroes: emptyUseCase)

                try await Task.sleep(nanoseconds: 500_000_000)

                #expect(viewModel.heroesData.isEmpty)
                #expect(viewModel.state == .error("Heroes not found"))
            }
        }
}

//Creo un mock que devuelva vacío para forzar el fallo
final class HeroesUseCaseEmptyMock: HeroesUseCaseProtocol {
    func getHeroes(filter: String) async -> [HeroResult] {
        return []
    }
}
