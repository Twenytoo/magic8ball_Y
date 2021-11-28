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
    func deleteEnity (answer: String)
    var answers: [AnswerEntity] { get set }
}
// MARK: - Class
class StorageManager: StorageServiceProtocol {
    var answers = [AnswerEntity]()
    weak var fetchControllerDelegate: NSFetchedResultsControllerDelegate?
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Answers")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private let context: NSManagedObjectContext
    init() {
        context = persistentContainer.viewContext
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
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
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func createAnswerEntity(answer: String) {
        let newEntity = AnswerEntity(context: context)
                    newEntity.text = answer
                    newEntity.date = Date()
                    saveContext()
    }
    func deleteEnity (answer: String) {
        for answerEntity in self.answers where answerEntity.text == answer {
            context.delete(answerEntity)
            saveContext()
        }
    }
}

extension SettingsViewController: NSFetchedResultsControllerDelegate {
}
extension AnswerEntity {
    func toAnswer() -> Answer {
        return Answer(text: self.text ?? L10n.error, date: self.date ?? Date())
    }
}
