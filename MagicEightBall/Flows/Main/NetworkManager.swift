//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import Foundation
import RxSwift

// MARK: - Protocol
protocol NetworkServiceProtocol {
    func fetchAnswerByURLRX()
    var answerRx: PublishSubject<Answer> { get set }
    var errorRX: PublishSubject<Void> { get set }
}
// MARK: - Class
class NetworkManager: NetworkServiceProtocol {
    var answerRx = PublishSubject<Answer>()
    var errorRX = PublishSubject<Void>()
    private var internetConnection = true
    private let createAnswerManager: CreateAnswerProtocol
    private let getAnswerWithoutConnectionManager: GetAnswerFromDBProtocol
    init(createAnswerManager: CreateAnswerProtocol,
         getAnswerWithoutConnectionManager: GetAnswerFromDBProtocol) {
        self.createAnswerManager = createAnswerManager
        self.getAnswerWithoutConnectionManager = getAnswerWithoutConnectionManager
    }
    func fetchAnswerByURLRX() {
        guard let url = URL(string: L10n.url) else {
            let answer = self.getAnswerWithoutConnectionManager.showAnswerWithoutConnection()
            answerRx.onNext(Answer(text: answer, date: Date()))
            answerRx.onError(MyError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if error != nil {
                let answer = self.getAnswerWithoutConnectionManager.showAnswerWithoutConnection()
                self.answerRx.onNext(Answer(text: answer, date: Date()))
                if self.internetConnection {
                    self.errorRX.onError(MyError.unableToComplete)
                    self.internetConnection = false
                }
                print(answer, "No Internet")
            } else {
                guard let data = data else {
                    self.errorRX.onError(MyError.invalidData)
                    return
                }
                guard let answer = self.parseJSON(withData: data) else {
                    self.errorRX.onError(MyError.invalidData)
                    return
                }
                self.internetConnection = true
                self.createAnswerManager.addNewAnswer(answer: answer)
                self.answerRx.onNext(Answer(text: answer, date: Date()))
                print(answer, "Internet success")
            }
        }.resume()
    }
    // MARK: - Parsing JSON data
    /// Parses JSON data
    ///
    /// Use data formatted Data to get an optional string formatted answer.
    /// In the case of an error, it will be printed in the terminal.
    ///
    /// - Returns: Optional String
    private func parseJSON(withData data: Data ) -> String? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DecodedData.self, from: data)
            return decodedData.magic.answer
        } catch {
            print(error)
        }
        return nil
    }
}
