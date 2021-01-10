//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

final class GetCityWeatherService {
    
    typealias WeatherResult = Swift.Result<CityWeather, Error>
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getWeather(request: URLRequest, completion: @escaping (WeatherResult) -> Void) {
        
        session.dataTask(with: request) { data, response, error in
            
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return try CityWeatherMapper.map(data, from: response)
                } else {
                    throw NetworkError.unexpectedDataRepresenation
                }
            })
        }.resume()
    }
}

final class CityWeatherMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> CityWeather {
        guard response.isOK, let weather = try? JSONDecoder().decode(CityWeather.self, from: data) else {
            throw NetworkError.invalidData
        }
        return weather
    }
}
