//
//  CoreDataManager.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import CoreData
// MARK: - Protocols
protocol StorageServiceProtocol {
    var context: NSManagedObjectContext { get set }
    func getObjects<T: NSManagedObject>(
                fetchController: NSFetchedResultsController<T>,
                completion: @escaping (Result<[T], Error>) -> Void)
    func saveContext()
}
// MARK: - Class
class StorageManager: StorageServiceProtocol {
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>?
    var context = AppDelegate.context!
    init() {
    }
    public func getObjects<T: NSManagedObject>(
                fetchController: NSFetchedResultsController<T>,
                completion: @escaping (Result<[T], Error>) -> Void) {
                do {
                    try fetchController.performFetch()
                    guard let result = fetchController.fetchedObjects else { return }
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
        }
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
