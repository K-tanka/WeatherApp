//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

final class GetCityWeatherMultiRequestDecorator {
    
    private let networkService: GetCityWeatherService
    private let concurrentQueue = DispatchQueue(label: "com.get.request.weather", qos: .userInitiated, attributes: .concurrent)
    private let group = DispatchGroup()
    
    init(networkService: GetCityWeatherService) {
        self.networkService = networkService
    }
    
    func requestWeatherForDefaultCities(requests: [URLRequest], completion: @escaping ([CityWeather]) -> Void) {
        var weathers = [CityWeather]()
        
        requests.forEach { [weak self] urlRequest in
            
            self?.group.enter()
            concurrentQueue.async {
                self?.networkService.getWeather(request: urlRequest, completion: { [weak self] result in
                    switch result {
                    case let .success(weather):
                        weathers.append(weather)
                    case .failure(_):
                        // Можно добавить обработку ошибок и в completion вернуть массив Swift.Result впоследствии отбразить юзеру ошибки по конкретным городам
                        assertionFailure()
                    }
                    self?.group.leave()
                })
            }
        }
        group.wait()
        group.notify(queue: DispatchQueue.main) {
            completion(weathers)
        }
    }
}
