import SwiftUI
import Testing
import ViewInspector

@testable import MarvelHeroesSwiftUI

struct HeroDetailViewTests {

    @Suite("Presentation Testing") struct PresentationTest {
        
        @Suite("HeroDetailView", .serialized) struct HeroDetailViewSuite {
            
            @Test("HeroDetailView muestra los datos del héroe correctamente")
            @MainActor
            func testHeroDetailView_ShowsHeroData() throws {
                // Arrange
                let viewModel = HeroDetailViewModel(hero: mockHero, useCaseSeries: SeriesUseCaseMock())
                let view = HeroDetailView(viewModel: viewModel)

                // Act
                let heroName = try view.inspect().find(text: "Hulk")
                let heroDescription = try view.inspect().find(text: "El gigante esmeralda más fuerte del universo Marvel.")

                // Assert
                #expect(heroName != nil)
                #expect(heroDescription != nil)
            }
            
            @Test("HeroDetailView muestra el estado de carga de series")
            @MainActor
            func testHeroDetailView_LoadingState() throws {
                // Arrange
                let viewModel = HeroDetailViewModel(hero: mockHero, useCaseSeries: SeriesUseCaseLoadingMock())
                let view = HeroDetailView(viewModel: viewModel)

                // Act
                let loadingView = try view.inspect().find(viewWithId: "loadingIndicator")

                // Assert
                #expect(loadingView != nil)
            }

            @Test("HeroDetailView muestra mensaje de error si no hay series")
            @MainActor
            func testHeroDetailView_ErrorState() async throws {
                // Arrange
                let viewModel = HeroDetailViewModel(hero: mockHero, useCaseSeries: SeriesUseCaseEmptyMock())
                let view = HeroDetailView(viewModel: viewModel)
                
                try await viewModel.getSeries()

                // Act
                print("🔍 Estado del ViewModel antes de la prueba: \(viewModel.state)") // 🔹 Depuración

                // Intentamos encontrar el mensaje de error en la vista
                let errorMessage = try? view.inspect().find(viewWithId: "errorMessage")

                // Assert
                #expect(errorMessage != nil)
            }
        }
    }
}

// Mock para simular un héroe
private let mockHero = HeroResult(
    id: 1011334,
    name: "Hulk",
    description: "El gigante esmeralda más fuerte del universo Marvel.",
    modified: Date(),
    thumbnail: HeroThumbnail(
        path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
        thumbnailExtension: .jpg
    ),
    resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
    comics: HeroComics(available: 12, collectionURI: "", items: [], returned: 12),
    series: HeroComics(available: 3, collectionURI: "", items: [], returned: 3),
    stories: HeroStories(available: 21, collectionURI: "", items: [], returned: 20),
    events: HeroComics(available: 1, collectionURI: "", items: [], returned: 1),
    urls: []
)

// Mock para simular estado de carga
final class SeriesUseCaseLoadingMock: SeriesUseCaseProtocol {
    func getSeries(heroID: Int) async -> [SerieResult] {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simula un retraso
        return []
    }
}

// Mock para simular estado de error
final class SeriesUseCaseEmptyMock: SeriesUseCaseProtocol {
    func getSeries(heroID: Int) async -> [SerieResult] {
        return []
    }
}
