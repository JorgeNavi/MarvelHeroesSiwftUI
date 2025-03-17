import Foundation
import CryptoKit

protocol SeriesNetworkProtocol {
    func fetchSeries(heroID: Int) async -> [SerieResult]
}

class NetworkSeries: SeriesNetworkProtocol {
    
    func fetchSeries(heroID: Int) async -> [SerieResult] {
        
        var modelReturn = [SerieResult]()
        
        let ts = ConstantsApp.CONS_API_TS
        let hash = generateMD5("\(ts)\(ConstantsApp.CONS_API_PRIVATE_KEY)\(ConstantsApp.CONS_API_PUBLIC_KEY)")
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.series(for: heroID))?ts=\(ts)&apikey=\(ConstantsApp.CONS_API_PUBLIC_KEY)&hash=\(hash)"
        
        print("URL de series Generada: \(urlCad)")
        
        guard let url = URL(string: urlCad) else {
            NSLog("Error building url")
            return modelReturn
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentTypeID)
        
        //Hacemos la llamada al servidor:
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("Código de respuesta: \(httpResponse.statusCode)")
                //print("Datos crudos recibidos: \(String(data: data, encoding: .utf8) ?? "No data")")
                
                if httpResponse.statusCode == 200 {
                    //print("📥 Datos crudos recibidos: \(String(data: data, encoding: .utf8) ?? "No data")")
                    do {
                        let decodedResponse = try JSONDecoder.marvelDecoder.decode(Serie.self, from: data)
                        modelReturn = decodedResponse.data.results
                        print("series recibidos: \(modelReturn.count)")
                    } catch {
                        print("Error decodificando JSON: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            print("Error en la solicitud HTTP: \(error.localizedDescription)")
        }
        
        return modelReturn
    }
    
    
    private func generateMD5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}


//Mock
final class NetworkSeriesMock: SeriesNetworkProtocol {
    func fetchSeries(heroID: Int) async -> [SerieResult] {
        let mockSeries: [SerieResult] = [
            SerieResult(
                id: 1001,
                title: "The Amazing Spider-Man",
                description: "A classic Spider-Man series with thrilling adventures.",
                resourceURI: "http://gateway.marvel.com/v1/public/series/1001",
                urls: [
                    SerieURLElement(type: "wiki", url: "https://marvel.com/spiderman_series")
                ],
                startYear: 1963,
                endYear: 2014,
                rating: "PG-13",
                type: "comic",
                modified: Date(),
                thumbnail: SerieThumbnail(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    thumbnailExtension: "jpg"
                ),
                creators: SerieCreators(
                    available: 2,
                    collectionURI: "",
                    items: [
                        SerieCreatorsItem(resourceURI: "", name: "Stan Lee", role: "Writer"),
                        SerieCreatorsItem(resourceURI: "", name: "Steve Ditko", role: "Artist")
                    ],
                    returned: 2
                ),
                characters: SerieCharacters(available: 3, collectionURI: "", items: [], returned: 3),
                stories: SerieStories(available: 5, collectionURI: "", items: [], returned: 5),
                comics: SerieCharacters(available: 20, collectionURI: "", items: [], returned: 20),
                events: SerieCharacters(available: 1, collectionURI: "", items: [], returned: 1),
                next: nil,
                previous: nil
            ),
            SerieResult(
                id: 1002,
                title: "X-Men: The Animated Series",
                description: "Follow the X-Men as they battle against evil mutants and humans alike.",
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
        ]
        
        return mockSeries
    }
}
