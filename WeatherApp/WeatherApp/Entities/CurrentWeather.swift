//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

struct CurrentWeather: Decodable {
    let temp: Int
    let icon: String
    let condition: WeatherCondition
    let humidity: Int
}
