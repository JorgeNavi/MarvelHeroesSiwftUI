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
 
                let mockUseCase = SeriesUseCaseMock()
                let hero = Self.heroTest
                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: mockUseCase)

                await viewModel.getSeries()

                #expect(viewModel.series.count == 2)
                #expect(viewModel.state == .loaded)
            }

            @Test("HeroDetailViewModel cambia a estado de error si no hay series")
            func heroDetailViewModelEmptyStateTest() async throws {
                
                let hero = Self.heroTest
                let emptyUseCase = SeriesUseCaseEmptyMockDetail()
                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: emptyUseCase)

                await viewModel.getSeries()

                #expect(viewModel.series.isEmpty)
                #expect(viewModel.state == .error("No TVShows found"))
            }
        }
}

//creo un useCase que devuelva vacío para forzar el fallo
final class SeriesUseCaseEmptyMockDetail: SeriesUseCaseProtocol {
    func getSeries(heroID: Int) async -> [SerieResult] {
        return []
    }
}


