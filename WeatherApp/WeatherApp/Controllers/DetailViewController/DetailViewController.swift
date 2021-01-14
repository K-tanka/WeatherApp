//
//  Created by MacBook Pro on 1/10/21.
//
import UIKit

final class DetailViewController: UIViewController, NibInit {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var sunriseTimeLabel: UILabel!
    @IBOutlet private weak var sunsetTimeLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(nibCell: DetailCell.self)
        }
    }
    
    var dataModel: DetailViewControllerDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard let headerModel = dataModel?.configureHeaderView() else {
            assertionFailure()
            return
        }
        
        cityLabel.text = headerModel.city
        conditionLabel.text = headerModel.condition
        tempLabel.text = "\(headerModel.temp) °C"
        sunriseTimeLabel.text = headerModel.sunrise
        sunsetTimeLabel.text = headerModel.sunset
    }    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel?.numberOfElements() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeue(reusable: DetailCell.self, for: indexPath)
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DetailCell, let cellModel = dataModel?.createCellModel(for: indexPath.row) else {
            assertionFailure()
            return
        }
        cell.configure(cellModel)
    }
}

