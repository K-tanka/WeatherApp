//
//  Created by MacBook Pro on 1/10/21.
//
import UIKit

enum TimeOfDay {
    case morning
    case day
    case evening
    case night
}

struct WeatherDetailByTime {
    let time: TimeOfDay
    let temp: String
    let condition: String
}

struct DetailCellViewModel {
    let date: String
    var weatherDetailByTime: [WeatherDetailByTime]
}

final class DetailCell: UITableViewCell {
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var morningTempLabel: UILabel!
    @IBOutlet private weak var dayTempLabel: UILabel!
    @IBOutlet private weak var eveningTempLabel: UILabel!
    @IBOutlet private weak var nightTempLabel: UILabel!
    
    @IBOutlet private weak var morningConditionLabel: UILabel!
    @IBOutlet private weak var dayConditionLabel: UILabel!
    @IBOutlet private weak var eveningConditionLabel: UILabel!
    @IBOutlet private weak var nightConditionLabel: UILabel!
    
    func configure(_ viewModel: DetailCellViewModel) {
        dateLabel.text = viewModel.date
        
        let morningWeather = viewModel.weatherDetailByTime.first(where: ({ $0.time == .morning }))
        let dayWeather = viewModel.weatherDetailByTime.first(where: ({ $0.time == .day }))
        let eveningWeather = viewModel.weatherDetailByTime.first(where: ( {$0.time == .evening }))
        let nightWeather = viewModel.weatherDetailByTime.first(where: ({ $0.time == .night }))
                
        morningTempLabel.text = morningWeather?.temp
        dayTempLabel.text = dayWeather?.temp
        eveningTempLabel.text = eveningWeather?.temp
        nightTempLabel.text = nightWeather?.temp
        
        morningConditionLabel.text = morningWeather?.condition
        dayConditionLabel.text = dayWeather?.condition
        eveningConditionLabel.text = eveningWeather?.condition
        nightConditionLabel.text = nightWeather?.condition
    }
}
