import Foundation
import Testing
import SwiftUI

@testable import MarvelHeroesSwiftUI

struct AppDataTests {

    @Suite("Data Testing") struct DataTest {
        
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
        
        @Suite("HeroesNetwork", .serialized) struct HeroesNetworkTests {
            
            @Test("NetworkHeroes maneja error correctamente")
            func heroesNetworkErrorTest() async throws {
                let heroesNetwork = NetworkHeroesErrorMock()

                let heroes = await heroesNetwork.fetchHeroes(filter: "")
                #expect(heroes.isEmpty)
                }
            }
        
        @Suite("SeriesNetwork", .serialized) struct SeriesNetworkTests {

            @Test("NetworkSeries maneja error correctamente")
            func seriesNetworkErrorTest() async throws {

                let seriesNetwork = NetworkSeriesErrorMock()
                let series = await seriesNetwork.fetchSeries(heroID: 1011334)
                #expect(series.isEmpty)
            }
        }
    }
}

//creo un NetworkHeroesMock que devuelva una lista vacia para forzar un error
final class NetworkHeroesErrorMock: HeroesNetworkProtocol {
    func fetchHeroes(filter: String) async -> [HeroResult] {
        return []
    }
}

//creo un NetworkSeriesMock que devuelva una lista vacia para forzar un error
final class NetworkSeriesErrorMock: SeriesNetworkProtocol {
    func fetchSeries(heroID: Int) async -> [SerieResult] {
        return [] // Simula una respuesta vacía
    }
}
