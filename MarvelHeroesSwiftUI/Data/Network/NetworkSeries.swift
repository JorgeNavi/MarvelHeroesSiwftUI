import Foundation
import CryptoKit

protocol SeriesNetworkProtocol {
    func fetchSeries(heroID: Int) async -> [Serie]
}

class NetworkSeries: SeriesNetworkProtocol {
    
    func fetchSeries(heroID: Int) async -> [Serie] {
        
        var modelReturn = [Serie]()
        
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
                print("Datos crudos recibidos: \(String(data: data, encoding: .utf8) ?? "No data")")
                
                if httpResponse.statusCode == 200 {
                    print("📥 Datos crudos recibidos: \(String(data: data, encoding: .utf8) ?? "No data")")
                    do {
                        let decodedResponse = try JSONDecoder.marvelDecoder.decode(SeriesResponse.self, from: data)
                        modelReturn = decodedResponse.data.results
                        print("series recibidos: \(modelReturn.count)")
                    } catch {
                        print("❌ Error decodificando JSON: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            print("❌ Error en la solicitud HTTP: \(error.localizedDescription)")
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
    func fetchSeries(heroID: Int) async -> [Serie] {
        let serie1 = Serie(
            id: 1,
            title: "The Incredible Hulk (1962 - 1999)",
            description: nil,
            resourceURI: "http://gateway.marvel.com/v1/public/series/1",
            urls: [
                URLElement(type: "detail", url: "http://marvel.com/comics/series/1")
            ],
            startYear: 1962,
            endYear: 1999,
            rating: "PG",
            type: "ongoing",
            modified: Date(),
            thumbnail: SerieThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                thumbnailExtension: "jpg"
            ),
            creators: Characters(available: 5, collectionURI: "", items: [], returned: 5),
            characters: Characters(available: 10, collectionURI: "", items: [], returned: 10),
            stories: Characters(available: 15, collectionURI: "", items: [], returned: 15),
            comics: Characters(available: 20, collectionURI: "", items: [], returned: 20),
            events: Characters(available: 2, collectionURI: "", items: [], returned: 2),
            next: nil,
            previous: nil
        )

        let serie2 = Serie(
            id: 2,
            title: "The Amazing Spider-Man (1999 - 2014)",
            description: nil,
            resourceURI: "http://gateway.marvel.com/v1/public/series/2",
            urls: [
                URLElement(type: "detail", url: "http://marvel.com/comics/series/2")
            ],
            startYear: 1999,
            endYear: 2014,
            rating: "T",
            type: "limited",
            modified: Date(),
            thumbnail: SerieThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/2/60/5232158de5b16",
                thumbnailExtension: "jpg"
            ),
            creators: Characters(available: 6, collectionURI: "", items: [], returned: 6),
            characters: Characters(available: 12, collectionURI: "", items: [], returned: 12),
            stories: Characters(available: 18, collectionURI: "", items: [], returned: 18),
            comics: Characters(available: 22, collectionURI: "", items: [], returned: 22),
            events: Characters(available: 3, collectionURI: "", items: [], returned: 3),
            next: nil,
            previous: nil
        )

        return [serie1, serie2]
    }
}
