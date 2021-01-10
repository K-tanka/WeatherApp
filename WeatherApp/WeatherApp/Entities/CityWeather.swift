//
//  Created by MacBook Pro on 1/9/21.
//
import Foundation

struct CityWeather: Decodable {
    
    let cityName: String
    let countryName: String
    let currentWeather: CurrentWeather
    let predictedWeather: [PredictedWeather]
    
    private enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case currentWeather = "fact"
        case locality
        case forecasts
        case country
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let geoObject = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .geoObject)
        let locality = try geoObject.nestedContainer(keyedBy: CodingKeys.self, forKey: .locality)
        let country = try geoObject.nestedContainer(keyedBy: CodingKeys.self, forKey: .country)
        cityName = try locality.decode(String.self, forKey: .name)
        countryName = try country.decode(String.self, forKey: .name)
        currentWeather = try values.decode(CurrentWeather.self, forKey: .currentWeather)
        predictedWeather = try values.decode([PredictedWeather].self, forKey: .forecasts)
    }
}
