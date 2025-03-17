
import SwiftUI
import Testing
import ViewInspector

@testable import MarvelHeroesSwiftUI

struct SerieCardViewTests {
    
    @Suite("Presentation Tests") struct SerieCardViewSuite {
        
        //mock de serie normal
        private let serie = SerieResult(
            id: 1001,
            title: "The Amazing Spider-Man",
            description: nil,
            resourceURI: "http://gateway.marvel.com/v1/public/series/1001",
            urls: [],
            startYear: 1963,
            endYear: 2014,
            rating: "PG-13",
            type: "comic",
            modified: Date(),
            thumbnail: SerieThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                thumbnailExtension: "jpg"
            ),
            creators: SerieCreators(available: 2, collectionURI: "", items: [], returned: 2),
            characters: SerieCharacters(available: 3, collectionURI: "", items: [], returned: 3),
            stories: SerieStories(available: 5, collectionURI: "", items: [], returned: 5),
            comics: SerieCharacters(available: 20, collectionURI: "", items: [], returned: 20),
            events: SerieCharacters(available: 1, collectionURI: "", items: [], returned: 1),
            next: nil,
            previous: nil
        )
        
        @Test("SerieCardView muestra los datos correctamente")
        @MainActor
        func testSerieCardView_RendersCorrectly() throws {
                        
            let view = SerieCardView(serie: serie)
            
            let titleText = try view.inspect().find(text: "The Amazing Spider-Man")

            #expect(titleText != nil)
        }
        
        @Test("SerieCardView maneja correctamente la falta de descripción")
        @MainActor
        func testSerieCardView_NoDescription() throws {
            
            let view = SerieCardView(serie: serie)
            
            let descriptionText = try view.inspect().find(text: "No description available.")
            
            #expect(descriptionText != nil)
        }
        
        @Test("SerieCardView muestra correctamente la imagen de la serie")
        @MainActor
        func testSerieCardView_Thumbnail() throws {
            
            let view = SerieCardView(serie: serie)
            
            let progressView = try view.inspect().find(viewWithId: "serie_image_loading_\(serie.id)")
            let asyncImage = try view.inspect().find(viewWithId: "serie_image_\(serie.id)")

            #expect(progressView != nil)
            #expect(asyncImage != nil)
        }
    }
}
