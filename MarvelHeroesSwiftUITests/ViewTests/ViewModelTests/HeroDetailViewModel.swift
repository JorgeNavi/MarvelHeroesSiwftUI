import Foundation
import Testing
import SwiftUI

@testable import MarvelHeroesSwiftUI

struct HeroDetailViewModelTests {

    @Suite("ViewModel Testing") struct HeroDetailViewModelTest {
        
            
            static let heroTest = HeroResult(
                id: 1011334,
                name: "Spiderman",
                description: "That guy in blue and red",
                modified: Date(),
                thumbnail: HeroThumbnail(path: "https://example.com/spidermanphoto", thumbnailExtension: .jpg),
                resourceURI: "http://examplehero.com",
                comics: HeroComics(available: 0, collectionURI: "", items: [], returned: 0),
                series: HeroComics(available: 0, collectionURI: "", items: [], returned: 0),
                stories: HeroStories(available: 0, collectionURI: "", items: [], returned: 0),
                events: HeroComics(available: 0, collectionURI: "", items: [], returned: 0),
                urls: []
            )

            @Test("HeroDetailViewModel carga series correctamente")
            func heroDetailViewModelFetchTest() async throws {
                // Arrange: Creamos un mock de `SeriesUseCase`
                let mockUseCase = SeriesUseCaseMock()
                let hero = Self.heroTest
                
                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: mockUseCase)

                // Act: Esperamos la carga de datos
                await viewModel.getSeries()

                // Assert: Verificamos que las series se cargaron correctamente y el estado es "loaded"
                #expect(viewModel.series.count == 2) // Mock devuelve 2 series
                #expect(viewModel.state == .loaded)
            }

            @Test("HeroDetailViewModel cambia a estado de error si no hay series")
            func heroDetailViewModelEmptyStateTest() async throws {
                // Arrange: Creamos un mock que devuelve una lista vacía
                final class SeriesUseCaseEmptyMock: SeriesUseCaseProtocol {
                    func getSeries(heroID: Int) async -> [SerieResult] {
                        return []
                    }
                }
                
                let hero = Self.heroTest

                let emptyUseCase = SeriesUseCaseEmptyMock()
                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: emptyUseCase)

                // Act: Esperamos la carga de datos
                await viewModel.getSeries()

                // Assert: Estado debe ser error y no debe haber series
                #expect(viewModel.series.isEmpty)
                #expect(viewModel.state == .error("No series found"))
            }
        }
}
