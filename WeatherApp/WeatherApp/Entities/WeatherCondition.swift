//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

enum WeatherCondition: String, Decodable {
    
    case clear
    case partlyCloudly = "partly-cloudy"
    case cloudy
    case overcast
    case drizzle
    case light = "light-rain"
    case rain
    case moderateRain = "moderate-rain"
    case heavyRain = "heavy-rain"
    case continuousHeavyRain = "continuous-heavy-rain"
    case showers
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow
    case snowShowers = "snow-showers"
    case hail
    case thunderstorm
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"
    
    
    var description: String {
        switch self {
        case .clear:
            return "ясно"
        case .partlyCloudly:
            return "малооблачно"
        case .cloudy:
            return "облачно с прояснениями"
        case .overcast:
            return "пасмурно"
        case .drizzle:
            return "морось"
        case .light:
            return "небольшой дождь"
        case .rain:
            return "дождь"
        case .moderateRain:
            return "умеренно сильный дождь"
        case .heavyRain:
            return "сильный дождь"
        case .continuousHeavyRain:
            return "длительный сильный дождь"
        case .showers:
            return "ливень"
        case .wetSnow:
            return "дождь со снегом"
        case .lightSnow:
            return "небольшой снег"
        case .snow:
            return "снег"
        case .snowShowers:
            return "снегопад"
        case .hail:
            return "град"
        case .thunderstorm:
            return "гроза"
        case .thunderstormWithRain:
            return "дождь с грозой"
        case .thunderstormWithHail:
            return "гроза с градом"
        }
    }
}
