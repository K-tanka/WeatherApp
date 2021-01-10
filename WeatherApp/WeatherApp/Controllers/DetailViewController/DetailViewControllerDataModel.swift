//
//  Created by MacBook Pro on 1/10/21.
//
import UIKit

protocol DetailViewControllerDataModel {
    func numberOfElements() -> Int
    func createCellModel(for index: Int) -> DetailCellViewModel
    func configureHeaderView() -> HeaderViewModel
}

final class DetailViewControllerDataModelImpl: DetailViewControllerDataModel {

    private let cityWeather: CityWeather
    
    init(cityWeather: CityWeather) {
        self.cityWeather = cityWeather
    }
    
    func numberOfElements() -> Int {
        3
    }
    
    func createCellModel(for index: Int) -> DetailCellViewModel {
        let item = cityWeather.predictedWeather[index]
        return getPresentingValues(for: item)
    }
    
    private func getPresentingValues(for day: PredictedWeather) -> DetailCellViewModel {
        
        var cellModel = DetailCellViewModel(date: day.date, weatherDetailByTime: [WeatherDetailByTime]())
        
        day.hours.forEach { timeWeather in
            switch timeWeather.hour {
            case "0":
                cellModel.weatherDetailByTime.append(getTimeWeatherDetail(time: .night, weather: timeWeather))
            case "8":
                cellModel.weatherDetailByTime.append(getTimeWeatherDetail(time: .morning, weather: timeWeather))
            case "12":
                cellModel.weatherDetailByTime.append(getTimeWeatherDetail(time: .day, weather: timeWeather))
            case "18":
                cellModel.weatherDetailByTime.append(getTimeWeatherDetail(time: .evening, weather: timeWeather))
            default: break
            }
        }
        
        return cellModel
    }
    
    func getTimeWeatherDetail(time: TimeOfDay, weather: HourWeather) -> WeatherDetailByTime {
        
        
        return WeatherDetailByTime(time: time, temp: "\(weather.temp) °C", condition: weather.condition.description)
    }
    
    func configureHeaderView() -> HeaderViewModel {
        let item = cityWeather.predictedWeather[0]
        return HeaderViewModel(city: item.date, condition: cityWeather.currentWeather.condition.description, temp: cityWeather.currentWeather.temp, sunrise: item.sunrise, sunset: item.sunset)
    }
}

