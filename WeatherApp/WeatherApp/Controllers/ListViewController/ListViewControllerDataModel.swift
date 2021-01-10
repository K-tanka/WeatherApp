//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

protocol ListViewControllerDataModel {
    var onDataSourceUpdated: (() -> Void)? { get set }
    
    func numberOfElements() -> Int
    func requestInitialCitiesWeather()
    func deleteElement(at index: Int)
    func createCellModel(for index: Int) -> WeatherCellViewModel
    func selectedCityWeather(at index: Int) -> CityWeather
    func filterItems(by str: String)
}

final class ListViewControllerDataModelImpl: ListViewControllerDataModel {
    
    private let networkService: GetCityWeatherMultiRequestDecorator
    private let citiesURLRequests: [URLRequest]
    private var citiesWeather = [CityWeather]()
    private var filteredWeather = [CityWeather]()
    
    var onDataSourceUpdated: (() -> Void)?
    
    init(networkService: GetCityWeatherMultiRequestDecorator, citiesURLRequests: [URLRequest]) {
        self.networkService = networkService
        self.citiesURLRequests = citiesURLRequests
    }
    
    func requestInitialCitiesWeather() {
        networkService.requestWeatherForDefaultCities(requests: citiesURLRequests) { [weak self] items in
            self?.filteredWeather.append(contentsOf: items)
            self?.citiesWeather.append(contentsOf: items)
            self?.onDataSourceUpdated?()
        }
    }
    
    func numberOfElements() -> Int {
        filteredWeather.count
    }
    
    func selectedCityWeather(at index: Int) -> CityWeather {
        filteredWeather[index]
    }
    
    func deleteElement(at index: Int) {
        filteredWeather.remove(at: index)
    }
    
    func createCellModel(for index: Int) -> WeatherCellViewModel {
        let item = filteredWeather[index]
        return WeatherCellViewModel(
            city: item.cityName,
            country: item.countryName,
            temp: "\(item.currentWeather.temp) °C",
            condition: item.currentWeather.condition.description)
    }
    
    func filterItems(by str: String) {
        if str.isEmpty {
            filteredWeather = citiesWeather
            onDataSourceUpdated?()
            return
        }
        filteredWeather = citiesWeather.filter({ $0.cityName.lowercased().contains(str.lowercased()) })
        onDataSourceUpdated?()
    }
}

