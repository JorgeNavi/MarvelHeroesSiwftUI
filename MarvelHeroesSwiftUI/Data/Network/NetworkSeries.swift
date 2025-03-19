import Foundation
import CryptoKit

protocol SeriesNetworkProtocol {
    func fetchSeries(heroID: Int) async -> [SerieResult]
}


//MARK: NetworkClass to fetch Series
class NetworkSeries: SeriesNetworkProtocol {
    
    func fetchSeries(heroID: Int) async -> [SerieResult] {
        
        var modelReturn = [SerieResult]()
        
        let ts = ConstantsApp.CONS_API_TS
        let hash = generateMD5("\(ts)\(ConstantsApp.CONS_API_PRIVATE_KEY)\(ConstantsApp.CONS_API_PUBLIC_KEY)")
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.series(for: heroID))?ts=\(ts)&apikey=\(ConstantsApp.CONS_API_PUBLIC_KEY)&hash=\(hash)"
        
        guard let url = URL(string: urlCad) else {
            NSLog("Error building url")
            return modelReturn
        }
        NSLog("url de series: \(urlCad)")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentTypeID)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                NSLog("Status Code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == HTTPResponseCodes.success {

                    do {
                        let decodedResponse = try JSONDecoder.marvelDecoder.decode(Serie.self, from: data)
                        modelReturn = decodedResponse.data.results
                        NSLog("series count: \(modelReturn.count)")
                    } catch {
                        NSLog("Error decoding JSON: \(error.localizedDescription)")
                    }
                }
                else {
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
final class NetworkSeriesMock: SeriesNetworkProtocol {
    func fetchSeries(heroID: Int) async -> [SerieResult] {
        return [
            SerieResult(
                id: 2258,
                title: "Uncanny X-Men (1963 - 2011)",
                description: "The flagship X-Men comic for over 40 years, Uncanny X-Men delivers action, suspense, and a hint of science fiction month in and month out.",
                resourceURI: "http://gateway.marvel.com/v1/public/series/2258",
                thumbnail: SerieThumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/9/00/512527be6fba3",
                    thumbnailExtension: "jpg"
                )
            ),
            SerieResult(
                id: 2104,
                title: "X-Men: Alpha (1995)",
                description: nil,
                resourceURI: "http://gateway.marvel.com/v1/public/series/2104",
                thumbnail: SerieThumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/51e705f412d45",
                    thumbnailExtension: "jpg"
                )
            )
        ]
    }
}
