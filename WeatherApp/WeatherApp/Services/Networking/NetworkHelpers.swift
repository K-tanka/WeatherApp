//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

enum URLRequestFactory {
    
    private static let baseURL = "https://api.weather.yandex.ru/v2/forecast?"
    
    private static let keyHeader = "X-Yandex-API-Key"
    private static let apiKey = "56e837fd-8518-40c6-96ae-42b285f6d4f7"
    
    private static func weatherURLFactory(for location: Location) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems?.append(URLQueryItem(name: "lat", value: location.lat))
        components?.queryItems?.append(URLQueryItem(name: "lon", value: location.lon))
        return components?.url
    }
    
    static func getURLRequest(for location: Location) -> URLRequest? {
        guard let url = weatherURLFactory(for: location) else {
            assertionFailure()
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: keyHeader)
        return request
    }
}

enum NetworkError: Error {
    case unexpectedDataRepresenation
    case urlCreationError
    case invalidData
}
