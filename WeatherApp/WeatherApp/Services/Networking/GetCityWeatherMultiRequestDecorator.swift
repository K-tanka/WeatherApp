//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

final class GetCityWeatherMultiRequestDecorator {
    
    private let networkService: GetCityWeatherService
    
    private let queue: OperationQueue =  {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    init(networkService: GetCityWeatherService) {
        self.networkService = networkService
    }
    
    func requestWeatherForDefaultCities(requests: [URLRequest], completion: @escaping ([CityWeather]) -> Void) {
        var weathers = [CityWeather]()
    
        requests.forEach { [weak self] urlRequest in
    
            queue.addOperation {
                self?.networkService.getWeather(request: urlRequest, completion: { result in
                    switch result {
                    case let .success(weather):
                        weathers.append(weather)
                    case .failure(_):
                        assertionFailure()
                    }
                    self?.semaphore.signal()
                })
            }
            self?.semaphore.wait()
        }

        completion(weathers)
    }
}
