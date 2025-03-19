
import SwiftUI
import Testing
import ViewInspector

@testable import MarvelHeroesSwiftUI

struct SerieCardViewTests {
    
    @Suite("Presentation Tests") struct SerieCardViewSuite {
        
        //mock de serie normal
        let serie = SerieResult(
            id: 1001,
            title: "The Amazing Spider-Man",
            description: nil,
            resourceURI: "http://spidermanserie.com",
            thumbnail: SerieThumbnail(
                path: "https://example.com/amazing-spiderman",
                thumbnailExtension: "jpg"
            )
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
