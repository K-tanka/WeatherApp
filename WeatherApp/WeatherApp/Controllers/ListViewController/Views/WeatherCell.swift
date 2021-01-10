//
//  Created by MacBook Pro on 1/9/21.
//
import UIKit

struct WeatherCellViewModel {
    let city: String
    let country: String
    let temp: String
    let condition: String
}

final class WeatherCell: UITableViewCell {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    
    func configure(_ viewModel: WeatherCellViewModel) {
        cityLabel.text = viewModel.city
        countryLabel.text = viewModel.country
        tempLabel.text = viewModel.temp
        conditionLabel.text = viewModel.condition
    }
}
