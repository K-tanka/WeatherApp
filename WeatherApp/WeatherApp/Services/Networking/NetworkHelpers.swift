//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

enum URLRequestFactory {
    
    private static let baseURL = "https://api.weather.yandex.ru/v2/forecast?"
    
    private static let keyHeader = "X-Yandex-API-Key"
    private static let apiKey = "6802647c-aaff-4a4f-b5d8-62c4a1cf5ec0"
    
    private static func weatherURLFactory(for location: Location) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems?.append(URLQueryItem(name: "lat", value: location.lat))
        components?.queryItems?.append(URLQueryItem(name: "lon", value: location.lon))
        return components?.url
    }
    
    static func iconStringURLFactory(for icon: String) -> URLRequest {
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg")!
        return URLRequest(url: url)
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
