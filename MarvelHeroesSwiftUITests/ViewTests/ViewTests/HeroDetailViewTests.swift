import SwiftUI
import Testing
import ViewInspector

@testable import MarvelHeroesSwiftUI

struct HeroDetailViewTests {

    @Suite("Presentation Testing") struct PresentationTest {
        
        @Suite("HeroDetailView", .serialized) struct HeroDetailViewSuite {
            
            private let hero = HeroResult(
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

            
            @Test("HeroDetailView muestra los datos del héroe correctamente")
            @MainActor
            func testHeroDetailView_ShowsHeroData() throws {
                
                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: SeriesUseCaseMock())
                let view = HeroDetailView(viewModel: viewModel)

                let heroDescription = try view.inspect().find(text: "El gigante esmeralda más fuerte del universo Marvel.")

                #expect(heroDescription != nil)
            }
            
            @Test("HeroDetailView muestra el estado de carga de series")
            @MainActor
            func testHeroDetailView_LoadingState() throws {

                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: SeriesUseCaseLoadingMock())
                let view = HeroDetailView(viewModel: viewModel)

                let loadingView = try view.inspect().find(viewWithId: "loadingIndicator")

                #expect(loadingView != nil)
            }

            @Test("HeroDetailView muestra mensaje de error si no hay series")
            @MainActor
            func testHeroDetailView_ErrorState() async throws {
                
                let viewModel = HeroDetailViewModel(hero: hero, useCaseSeries: SeriesUseCaseEmptyMock())
                let view = HeroDetailView(viewModel: viewModel)
                
                try await viewModel.getSeries(heroID: 1011334)

                let errorMessage = try? view.inspect().find(viewWithId: "errorMessage")

                #expect(errorMessage != nil)
            }
        }
    }
}


//Mock para simular estado de carga
final class SeriesUseCaseLoadingMock: SeriesUseCaseProtocol {
    func getSeries(heroID: Int) async -> [SerieResult] {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return []
    }
}

//Mock para simular estado de error
final class SeriesUseCaseEmptyMock: SeriesUseCaseProtocol {
    func getSeries(heroID: Int) async -> [SerieResult] {
        return []
    }
}
