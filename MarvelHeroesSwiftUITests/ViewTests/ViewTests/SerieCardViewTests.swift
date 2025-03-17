
import SwiftUI
import Testing
import ViewInspector

@testable import MarvelHeroesSwiftUI

struct SerieCardViewTests {
    
    @Suite("Presentation Tests") struct SerieCardViewSuite {
        
        @Test("SerieCardView muestra los datos correctamente")
        @MainActor
        func testSerieCardView_RendersCorrectly() throws {
            // Arrange: Creamos una serie mockeada
            let mockSerie = SerieResult(
                id: 1001,
                title: "The Amazing Spider-Man",
                description: "A classic Spider-Man series.",
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
            
            let view = SerieCardView(serie: mockSerie)
            
            // Act: Inspeccionamos la vista
            let titleText = try view.inspect().find(text: "The Amazing Spider-Man")
            let descriptionText = try view.inspect().find(text: "A classic Spider-Man series.")

            // Assert
            #expect(titleText != nil)
            #expect(descriptionText != nil)
        }
        
        @Test("SerieCardView maneja correctamente la falta de descripción")
        @MainActor
        func testSerieCardView_NoDescription() throws {
            // Arrange: Serie sin descripción
            let mockSerie = SerieResult(
                id: 1002,
                title: "X-Men: The Animated Series",
                description: nil, // 🔹 Sin descripción
                resourceURI: "http://gateway.marvel.com/v1/public/series/1002",
                urls: [],
                startYear: 1992,
                endYear: 1997,
                rating: "TV-Y7",
                type: "animated",
                modified: Date(),
                thumbnail: SerieThumbnail(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                    thumbnailExtension: "jpg"
                ),
                creators: SerieCreators(available: 1, collectionURI: "", items: [], returned: 1),
                characters: SerieCharacters(available: 5, collectionURI: "", items: [], returned: 5),
                stories: SerieStories(available: 2, collectionURI: "", items: [], returned: 2),
                comics: SerieCharacters(available: 10, collectionURI: "", items: [], returned: 10),
                events: SerieCharacters(available: 0, collectionURI: "", items: [], returned: 0),
                next: nil,
                previous: nil
            )
            
            let view = SerieCardView(serie: mockSerie)
            
            // Act: Inspeccionamos la vista
            let descriptionText = try view.inspect().find(text: "No description available.")
            
            // Assert
            #expect(descriptionText != nil)
        }
        
        @Test("SerieCardView muestra correctamente la imagen de la serie")
        @MainActor
        func testSerieCardView_Thumbnail() throws {
            // Arrange: Serie con imagen
            let mockSerie = SerieResult(
                id: 1003,
                title: "Avengers Assemble",
                description: "Animated series featuring Earth's mightiest heroes.",
                resourceURI: "http://gateway.marvel.com/v1/public/series/1003",
                urls: [],
                startYear: 2013,
                endYear: 2019,
                rating: "TV-Y7",
                type: "animated",
                modified: Date(),
                thumbnail: SerieThumbnail(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/6/00/5232158de5b16",
                    thumbnailExtension: "jpg"
                ),
                creators: SerieCreators(available: 1, collectionURI: "", items: [], returned: 1),
                characters: SerieCharacters(available: 5, collectionURI: "", items: [], returned: 5),
                stories: SerieStories(available: 2, collectionURI: "", items: [], returned: 2),
                comics: SerieCharacters(available: 10, collectionURI: "", items: [], returned: 10),
                events: SerieCharacters(available: 0, collectionURI: "", items: [], returned: 0),
                next: nil,
                previous: nil
            )
            
            let view = SerieCardView(serie: mockSerie)
            
            // Act: Inspeccionamos la vista
            let progressView = try view.inspect().find(viewWithId: "serie_image_loading_\(mockSerie.id)")
            let asyncImage = try view.inspect().find(viewWithId: "serie_image_\(mockSerie.id)")

            // Assert: Primero la carga, luego la imagen
            #expect(progressView != nil) // La imagen empieza en carga
            #expect(asyncImage != nil)   // Luego se muestra la imagen
        }
    }
}
