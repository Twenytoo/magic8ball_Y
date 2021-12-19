//
//  FlowCoordinator.swift
//  MagicEightBall
//
//  Created by Артём on 18.12.2021.
//

import Foundation
import UIKit

protocol FlowCoordinator {
    var containerViewController: UIViewController? { get set }
    @discardableResult
    func createFlow() -> UIViewController
}
