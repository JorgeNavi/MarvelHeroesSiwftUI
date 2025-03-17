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
                description: "a spiderman show",
                resourceURI: "http://spidermanserie.com",
                urls: [SerieURLElement(type: "detail", url: "http://marvel.com/spiderman")],
                startYear: 1963,
                endYear: 2021,
                rating: "PG-13",
                type: "ongoing",
                modified: Date(),
                thumbnail: SerieThumbnail(path: "https://example.com/amazing-spiderman", thumbnailExtension: "jpg"),
                creators: SerieCreators(available: 1, collectionURI: "", items: [SerieCreatorsItem(resourceURI: "http://marvel.com/creator", name: "Stan Lee", role: "Writer")], returned: 1),
                characters: SerieCharacters(available: 1, collectionURI: "", items: [SerieNext(resourceURI: "http://marvel.com/character", name: "Spider-Man")], returned: 1),
                stories: SerieStories(available: 1, collectionURI: "", items: [SerieStoriesItem(resourceURI: "http://marvel.com/story", name: "Origin Story", type: .interiorStory)], returned: 1),
                comics: SerieCharacters(available: 1, collectionURI: "", items: nil, returned: 1),
                events: SerieCharacters(available: 1, collectionURI: "", items: nil, returned: 1),
                next: nil,
                previous: nil
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
                #expect(serie.description == "a spiderman show")
                #expect(serie.photo == "https://example.com/amazing-spiderman.jpg")
                #expect(serie.startYear == 1963)
                #expect(serie.endYear == 2021)
                #expect(serie.rating == "PG-13")
                #expect(serie.urls.first?.url == "http://marvel.com/spiderman")
            }
        }
        
        @Suite("UseCases", .serialized) struct UseCasesTests {

            @Test("HeroesUseCase return heroes")
            func heroesUseCaseTest() async throws {
                
                let repositoryMock = HeroesRepositoryMock()
                let useCase = HeroesUseCaseMock(repository: repositoryMock)
                let heroes = await useCase.getHeroes(filter: "")
                
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
                #expect(series.first?.title == "The Amazing Spider-Man")
                #expect(series.last?.title == "X-Men: The Animated Series")
            }
        }
    }
}
