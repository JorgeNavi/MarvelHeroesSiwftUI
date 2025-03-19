import Foundation
import Testing
import SwiftUI

@testable import MarvelHeroesSwiftUI

struct AppDomainTests {


    @Suite("Domain Testing") struct DomainTest {
        
        @Suite("Models", .serialized) struct ModelsTests {
            
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
            
            static let serieTest = SerieResult(
                id: 1001,
                title: "The Amazing Spider-Man",
                description: "A Spider-Man show",
                resourceURI: "http://spidermanserie.com",
                thumbnail: SerieThumbnail(
                    path: "https://example.com/amazing-spiderman",
                    thumbnailExtension: "jpg"
                )
            )

            @Test("HeroResult Model")
            func modelHeroTest() async throws {
                let hero = Self.heroTest
                #expect(hero.id == 1011334)
                #expect(hero.name == "Spiderman")
                #expect(hero.description == "That guy in blue and red")
                #expect(hero.photo == "https://example.com/spidermanphoto.jpg")
            }
            
            @Test("SerieResult Model")
            func modelSerieTest() async throws {
                let serie = Self.serieTest
                #expect(serie.id == 1001)
                #expect(serie.title == "The Amazing Spider-Man")
                #expect(serie.description == "A Spider-Man show")
                #expect(serie.photo == "https://example.com/amazing-spiderman.jpg")
            }
        }
        
        @Suite("UseCases", .serialized) struct UseCasesTests {

            @Test("HeroesUseCase return heroes")
            func heroesUseCaseTest() async throws {
                
                let repositoryMock = HeroesRepositoryMock()
                let useCase = HeroesUseCaseMock(repository: repositoryMock)
                let heroes = await useCase.getHeroes()
                
                #expect(heroes.count == 2)
                #expect(heroes.first?.name == "Spider-Man")
                #expect(heroes.last?.name == "Iron Man")
            }
            
            @Test("SeriesUseCase return series")
            func seriesUseCaseTest() async throws {

                let repositoryMock = SeriesRepositoryMock()
                let useCase = SeriesUseCaseMock(repository: repositoryMock)

                let series = await useCase.getSeries(heroID: 1)

                #expect(series.count == 2)
                #expect(series.first?.title == "Uncanny X-Men (1963 - 2011)")
                #expect(series.last?.title == "X-Men: Alpha (1995)")
            }
        }
    }
}
