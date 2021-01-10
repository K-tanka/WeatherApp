//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

protocol ListViewControllerDataModel {
    func numberOfElements() -> Int
    func requestInitialCitiesWeather(completion: @escaping () -> Void)
    func deleteElement(at index: Int)
    func createCellModel(for index: Int) -> WeatherCellViewModel
}

final class ListViewControllerDataModelImpl: ListViewControllerDataModel {
    
    private let networkService: GetCityWeatherMultiRequestDecorator
    private let citiesURLRequests: [URLRequest]
    private var citiesWeather = [CityWeather]()
    
    init(networkService: GetCityWeatherMultiRequestDecorator, citiesURLRequests: [URLRequest]) {
        self.networkService = networkService
        self.citiesURLRequests = citiesURLRequests
    }
    
    func requestInitialCitiesWeather(completion: @escaping () -> Void) {
        networkService.requestWeatherForDefaultCities(requests: citiesURLRequests) { [weak self] items in
            self?.citiesWeather.append(contentsOf: items)
            completion()
        }
    }
    
    func numberOfElements() -> Int {
        citiesWeather.count
    }
    
    func deleteElement(at index: Int) {
        citiesWeather.remove(at: index)
    }
    
    func createCellModel(for index: Int) -> WeatherCellViewModel {
        let item = citiesWeather[index]
        return WeatherCellViewModel(
            city: item.cityName,
            country: item.countryName,
            temp: "\(item.currentWeather.temp) °C",
            condition: item.currentWeather.condition.description)
    }
}

