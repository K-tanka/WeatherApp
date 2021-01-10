//
//  Created by MacBook Pro on 1/9/21.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//      Не стала выносить в отдельный метод, так же создавать отдельную сущность для роутинга, так как приложение очень маленькое.
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = ControllersFactory.initListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}


enum ControllersFactory {
    
    static func initListViewController() -> ListViewController {
        let requests = Constants.defaulCities.compactMap(URLRequestFactory.getURLRequest)
        let networkService = GetCityWeatherService()
        let decoratedNetworkService = GetCityWeatherMultiRequestDecorator(networkService: networkService)
        let dataModel = ListViewControllerDataModelImpl(networkService: decoratedNetworkService, citiesURLRequests: requests)
        let controller = ListViewController.initFromNib()
        controller.dataModel = dataModel
        return controller
    }
}
