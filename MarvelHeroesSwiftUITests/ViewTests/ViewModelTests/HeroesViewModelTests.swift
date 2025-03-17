import Foundation
import Testing
import SwiftUI

@testable import MarvelHeroesSwiftUI

struct HeroesViewModelTests {

    @Suite("ViewModel Testing") struct ViewModelTest {
        

            @Test("HeroesViewModel carga héroes correctamente")
            func heroesViewModelFetchTest() async throws {
                // Arrange: Usamos el mock de HeroesUseCase
                let mockUseCase = HeroesUseCaseMock()
                let viewModel = HeroesViewModel(useCaseHeroes: mockUseCase)

                // Act: Esperamos a que termine la carga
                await viewModel.getHeroes()

                // Assert: Verificamos que se cargaron héroes y el estado es "loaded"
                #expect(viewModel.heroesData.count == 2)
                #expect(viewModel.state == .loaded)
            }


            @Test("HeroesViewModel cambia a estado de error si no hay héroes")
            func heroesViewModelEmptyStateTest() async throws {
                // Arrange: Mock que devuelve lista vacía
                final class HeroesUseCaseEmptyMock: HeroesUseCaseProtocol {
                    func getHeroes(filter: String) async -> [HeroResult] {
                        return []
                    }
                }

                let emptyUseCase = HeroesUseCaseEmptyMock()
                let viewModel = HeroesViewModel(useCaseHeroes: emptyUseCase)

                // Act: Esperamos la carga
                try await Task.sleep(nanoseconds: 500_000_000)

                // Assert: Estado debe ser error y no debe haber héroes
                #expect(viewModel.heroesData.isEmpty)
                #expect(viewModel.state == .error("Heroes not found"))
            }
        }
}
