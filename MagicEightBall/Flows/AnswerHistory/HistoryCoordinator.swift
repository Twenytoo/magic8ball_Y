//
//  HistoryCoordinator.swift
//  MagicEightBall
//
//  Created by Артём on 19.12.2021.
//

import UIKit

class HistoryCoordinator: NavigationNode {
    var storageManager: StorageServiceProtocol
    weak var containerViewController: UIViewController?
    init(   parent: NavigationNode?,
            storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
        super.init(parent: parent)
    }
    deinit {
        print("HistoryCoordinator deinit")
    }
}

extension HistoryCoordinator: FlowCoordinator {
    func createFlow() -> UIViewController {
        let historyModel = HistoryModel(storageManager: storageManager)
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        containerViewController = historyViewController
        return historyViewController
    }
}
