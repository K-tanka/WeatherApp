//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

struct PredictedWeather: Decodable {
    let date: String
    let sunrise: String
    let sunset: String
    let hours: [HourWeather]
}

struct HourWeather: Decodable {
    let hour: String
    let temp: Int
    let icon: String
    let condition: WeatherCondition
    let humidity: Int
}
