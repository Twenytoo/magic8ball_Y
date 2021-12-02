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
    func createAnswerEntity(answer: String)
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
    func deleteAnswerAt(indexPath: Int)
}
// MARK: - Class
class StorageManager: StorageServiceProtocol {
    private var answers = [AnswerEntity]()
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    init() {
        persistentContainer = {
            let container = NSPersistentContainer(name: "Answers")
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        context = persistentContainer.viewContext
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
        let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: backgroundContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        getObjects(fetchController: controller) { result in
            switch result {
            case .success(let answerEntities):
                completion(answerEntities)
                self.answers = answerEntities
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    // MARK: - Core Data Saving support
    private func saveBackgroundContext (for backgroundContext: NSManagedObjectContext) {
        backgroundContext.perform {
            if backgroundContext.hasChanges {
                do {
                    try backgroundContext.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    func createAnswerEntity(answer: String) {
//        let newEntity = AnswerEntity(context: backgroundContext)
//        newEntity.text = answer
//        newEntity.date = Date()
//        saveBackgroundContext(for: backgroundContext)
    }
    func deleteAnswerAt(indexPath: Int) {
//        for id in 0...50 {
//            let answer = answers[id]
//            backgroundContext.perform {
//                self.backgroundContext.delete(answer)
//                self.saveBackgroundContext(for: self.backgroundContext)
//            }
//        }
        
        let answer = answers[indexPath]
        backgroundContext.perform {
            self.backgroundContext.delete(answer)
            self.saveBackgroundContext(for: self.backgroundContext)
        }
    }
}

extension AnswerEntity {
    func toAnswer() -> Answer {
        return Answer(text: self.text ?? L10n.error, date: self.date ?? Date())
    }
}
