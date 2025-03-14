
import Foundation
import CryptoKit

protocol HeroesNetworkProtocol {
    func fetchHeroes(filter: String) async -> [Hero]
}

class NetworkHeroes: HeroesNetworkProtocol {
    
    func fetchHeroes(filter: String) async -> [Hero] {
        
        var modelReturn = [Hero]()
        
        let ts = ConstantsApp.CONS_API_TS
        let hash = generateMD5("\(ts)\(ConstantsApp.CONS_API_PRIVATE_KEY)\(ConstantsApp.CONS_API_PUBLIC_KEY)")
        
        let filterParam = filter.isEmpty ? "" : "&nameStartsWith=\(filter)" //establecemos aqui la diferencia entre si el filtro va vacio o no
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.heroes.rawValue)?ts=\(ts)&apikey=\(ConstantsApp.CONS_API_PUBLIC_KEY)&hash=\(hash)\(filterParam)"
        print("URL Generada: \(urlCad)")
        
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
                    do {
                        let decodedResponse = try JSONDecoder().decode(HeroResponse.self, from: data)
                        modelReturn = decodedResponse.data.results
                        print("Héroes recibidos: \(modelReturn.count)")
                    } catch {
                        print("❌ Error decodificando JSON: \(error.localizedDescription)")
                    }
                } else {
                    print("❌ Error en la petición: Código \(httpResponse.statusCode)")
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
