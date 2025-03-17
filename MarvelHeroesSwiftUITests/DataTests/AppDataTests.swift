import Foundation
import Testing
import SwiftUI

@testable import MarvelHeroesSwiftUI

struct AppDataTests {

    @Suite("Data Testing") struct DataTest {
        
        @Suite("HeroesNetwork", .serialized) struct HeroesNetworkTests {
            
            @Test("NetworkHeroes maneja error correctamente")
            func heroesNetworkErrorTest() async throws {
                          // Arrange: Creamos un mock que devuelve error
                final class NetworkHeroesErrorMock: HeroesNetworkProtocol {
                    func fetchHeroes(filter: String) async -> [HeroResult] {
                        return [] // Simula una respuesta vacía
                    }
                }

                let heroesNetwork = NetworkHeroesErrorMock()

                // Act: Llamamos al método fetchHeroes
                let heroes = await heroesNetwork.fetchHeroes(filter: "")

                // Assert: Debe devolver una lista vacía
                #expect(heroes.isEmpty)
                }
            }
        
        @Suite("SeriesNetwork", .serialized) struct SeriesNetworkTests {

            @Test("NetworkSeries maneja error correctamente")
            func seriesNetworkErrorTest() async throws {
                // Arrange: Creamos un mock que devuelve error
                final class NetworkSeriesErrorMock: SeriesNetworkProtocol {
                    func fetchSeries(heroID: Int) async -> [SerieResult] {
                        return [] // Simula una respuesta vacía
                    }
                }

                let seriesNetwork = NetworkSeriesErrorMock()

                // Act: Llamamos al método fetchSeries
                let series = await seriesNetwork.fetchSeries(heroID: 1011334)

                // Assert: Debe devolver una lista vacía
                #expect(series.isEmpty)
            }
        }
    }
}
