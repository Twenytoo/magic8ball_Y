//
//  CoreDataManager.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import CoreData
import RxSwift
// MARK: - Protocols
protocol StorageServiceProtocol {
    func createAnswerEntity(answer: String)
    func deleteAnswerAt(indexPath: Int)
    func getAnswersFromDBRX()
    var answerRx: BehaviorSubject<[AnswerEntity]> { get }
}
protocol CreateAnswerProtocol {
    func addNewAnswer(answer: String)
}
protocol GetAnswerFromDBProtocol: AnyObject {
    func showAnswerWithoutConnection() -> String
}
// MARK: - Class
class StorageManager: StorageServiceProtocol {
    var answerRx = BehaviorSubject<[AnswerEntity]>(value: [])
    private var answers = [AnswerEntity]()
    private let disposeBag = DisposeBag()
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
    private func getObjects<T: NSManagedObject>(
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
        getAnswersFromDBRX()
    }
    func createAnswerEntity(answer: String) {
        let newEntity = AnswerEntity(context: backgroundContext)
        newEntity.text = answer
        newEntity.date = Date()
        saveBackgroundContext(for: backgroundContext)
    }
    func deleteAnswerAt(indexPath: Int) {
        let answer = answers[indexPath]
        backgroundContext.perform {
            self.backgroundContext.delete(answer)
            self.saveBackgroundContext(for: self.backgroundContext)
        }
    }
}

// MARK: - RX
extension StorageManager {
    func getAnswersFromDBRX() {
            let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                        managedObjectContext: self.backgroundContext,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
            self.getObjects(fetchController: controller) { result in
                switch result {
                case .success(let answerEntities):
                    self.answerRx.onNext(answerEntities)
                    self.answers = answerEntities
                case .failure(let error):
                    self.answerRx.onError(error)
                }
        }
    }
}
// MARK: - Save answer for NetworkManager
extension StorageManager: CreateAnswerProtocol {
    func addNewAnswer(answer: String) {
        createAnswerEntity(answer: answer)
    }
}
// MARK: - Get answer without Internet
extension StorageManager: GetAnswerFromDBProtocol {
    func showAnswerWithoutConnection() -> String {
        var answer = L10n.error
        answerRx
            .map { $0.map { $0.text ?? L10n.error }}
            .subscribe(onNext: {
                answer = $0.randomElement() ?? L10n.error
            }).disposed(by: disposeBag)
        return answer
    }
}
// MARK: - AnswerEntity to Answer
extension AnswerEntity {
    func toAnswer() -> Answer {
        return Answer(text: self.text ?? L10n.error, date: self.date ?? Date())
    }
}
