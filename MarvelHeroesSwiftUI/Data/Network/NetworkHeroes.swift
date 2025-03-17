
import Foundation
import CryptoKit

protocol HeroesNetworkProtocol {
    func fetchHeroes(filter: String) async -> [HeroResult]
}

//MARK: NetworkClass to fetch Heroes
class NetworkHeroes: HeroesNetworkProtocol {
    
    func fetchHeroes(filter: String) async -> [HeroResult] {
        
        var modelReturn = [HeroResult]()
        let ts = ConstantsApp.CONS_API_TS
        let hash = generateMD5("\(ts)\(ConstantsApp.CONS_API_PRIVATE_KEY)\(ConstantsApp.CONS_API_PUBLIC_KEY)")
        
        //stablishing an url for searching
        let filterParam = filter.isEmpty ? "" : "&nameStartsWith=\(filter)"
        
        //Url
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.heroes.rawValue)?ts=\(ts)&apikey=\(ConstantsApp.CONS_API_PUBLIC_KEY)&hash=\(hash)\(filterParam)"
        
        guard let url = URL(string: urlCad) else {
            NSLog("Error building url")
            return modelReturn
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentTypeID)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                NSLog("Status Code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == HTTPResponseCodes.success {

                    do {
                        let decodedResponse = try JSONDecoder.marvelDecoder.decode(Hero.self, from: data)
                        modelReturn = decodedResponse.data.results
                        NSLog("heroes count: \(modelReturn.count)")
                    } catch {
                        NSLog("Error decoding JSON: \(error.localizedDescription)")
                    }
                } else {
                    NSLog("Request Error: Code \(httpResponse.statusCode)")
                }
            }
        } catch {
            NSLog("HTTP Error: \(error.localizedDescription)")
        }
        
        return modelReturn
    }
    
    //Func to generate MD5
    private func generateMD5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}


//MARK: Mock for testing and previews
final class NetworkHeroesMock: HeroesNetworkProtocol {
    func fetchHeroes(filter: String) async -> [HeroResult] {
        let hero1 = HeroResult(
            id: 1011334,
            name: "Spider-Man",
            description: "El icónico héroe de Marvel con habilidades arácnidas.",
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

        let hero2 = HeroResult(
            id: 1009368,
            name: "Iron Man",
            description: "Tony Stark, un genio multimillonario que usa su armadura de Iron Man.",
            modified: Date(),
            thumbnail: HeroThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55",
                thumbnailExtension: .jpg
            ),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009368",
            comics: HeroComics(available: 15, collectionURI: "", items: [], returned: 15),
            series: HeroComics(available: 5, collectionURI: "", items: [], returned: 5),
            stories: HeroStories(available: 30, collectionURI: "", items: [], returned: 30),
            events: HeroComics(available: 2, collectionURI: "", items: [], returned: 2),
            urls: []
        )

        return [hero1, hero2]
    }
}
