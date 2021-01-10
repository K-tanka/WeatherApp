//
//  Created by MacBook Pro on 1/9/21.
//
import UIKit

final class ListViewController: UIViewController, NibInit {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(nibCell: WeatherCell.self)
        }
    }
    
    var dataModel: ListViewControllerDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDataRequest()
    }
    
    private func initialDataRequest() {
        dataModel?.requestInitialCitiesWeather { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel?.numberOfElements() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return  tableView.dequeue(reusable: WeatherCell.self, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? WeatherCell, let cellModel = dataModel?.createCellModel(for: indexPath.row) else {
            assertionFailure()
            return
        }
        cell.configure(cellModel)
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        
        case .none, .insert: break
        case .delete:
            dataModel?.deleteElement(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        @unknown default:
            assertionFailure()
        }
    }
}

extension ListViewController: UISearchBarDelegate {
    
}
