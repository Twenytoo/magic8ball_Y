//
//  TabBarPages.swift
//  MagicEightBall
//
//  Created by Артём on 19.12.2021.
//

import UIKit

// MARK: - Enum
enum TabBarPages {
    case main
    case settings
    case history

    init?(index: Int) {
        switch index {
        case 0:
            self = .main
        case 1:
            self = .settings
        case 2:
            self = .history
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .main:     return L10n.main
        case .settings: return L10n.settings
        case .history:  return L10n.history
        }
    }
    func pageOrderNumber() -> Int {
        switch self {
        case .main:
            return 0
        case .settings:
            return 1
        case .history:
            return 2
        }
    }
    func pageIconValue() -> UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "restart.circle")
        case .settings:
            return UIImage(systemName: "gear")
        case .history:
            return UIImage(systemName: "note.text")
        }
    }
}

// MARK: - TabBarCoordinator
class TabBarCoordinator: NavigationNode {
    var storageManager: StorageServiceProtocol!
    var networkManager: NetworkServiceProtocol!
    var secureStorageService: SecureStorageServiceProtocol!
    weak var containerViewController: UIViewController?
//    let navigationController: UINavigationController
//    let tabBarController: UITabBarController
    
    override init(parent: NavigationNode?) {
//        self.navigationController = .init()
//        self.tabBarController = .init()
        super.init(parent: parent)
    }
    deinit {
        print("TabCoordinator deinit")
    }
//    func start() {
//        let pages: [TabBarPages] = [.main, .settings, .history]
//            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
//
//        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
//
//        return prepareTabBarController(withTabControllers: controllers)
//    }
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPages.main.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.backgroundColor = .black
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        return tabBarController
    }
    private func getTabController(_ page: TabBarPages) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIconValue(),
                                                     tag: page.pageOrderNumber())
        switch page {
        case .main:
            let coordinator = MainCoordinator(parent: self)
            coordinator.storageManager = storageManager
            coordinator.networkManager = networkManager
            coordinator.secureStorageService = secureStorageService
            navController.pushViewController(coordinator.createFlow(), animated: true)
        case .settings:
            let coordinator = SettingsCoordinator(parent: self)
            coordinator.storageManager = storageManager
            navController.pushViewController(coordinator.createFlow(), animated: true)
        case .history:
            let coordinator = HistoryCoordinator(parent: self)
            coordinator.storageManager = storageManager
            navController.pushViewController(coordinator.createFlow(), animated: true)
        }
        return navController
    }
}

extension TabBarCoordinator: FlowCoordinator {    
    func createFlow() -> UIViewController {
        let pages: [TabBarPages] = [.main, .settings, .history]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        return prepareTabBarController(withTabControllers: controllers)
    }
}
