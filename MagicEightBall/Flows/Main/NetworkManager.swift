//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import Foundation
import RxSwift

// MARK: - Protocol
protocol NetworkService {
    func fetchAnswerByURLRX()
    var answerRx: PublishSubject<Answer> { get set }
}
// MARK: - Class
class NetworkManager: NetworkService {
    /// Handles an instance of String type in case of unsuccessful internet connection
//    var completionHandler: ((String) -> Void)?
    var answerRx = PublishSubject<Answer>()
    /// Shows answers from DB in case of unsuccessful internet connection
    private var createAnswerManager: CreateAnswerProtocol
    private var getAnswerWithoutConnectionManager: GetAnswerFromDBProtocol
    init(createAnswerManager: CreateAnswerProtocol,
         getAnswerWithoutConnectionManager: GetAnswerFromDBProtocol) {
        self.createAnswerManager = createAnswerManager
        self.getAnswerWithoutConnectionManager = getAnswerWithoutConnectionManager
    }
    // MARK: - RX
    // MARK: - Getting data from Network
    /// Receiving data from the Internet using URLSession
    /// The function uses url to receive data, response and error using the URLSession
    /// where an instance of ViewController is created on the main queue and receives an instance of the String type
    /// from there and is handler by the complitionHandler
    /// - Returns: The function returns Void, but calls the function URLSession
    func fetchAnswerByURLRX() {
        guard let url = URL(string: L10n.url) else {
            let answer = self.getAnswerWithoutConnectionManager.showAnswerWithoutConnection()
            answerRx.onNext(Answer(text: answer, date: Date()))
            answerRx.onError(MyError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            print("!!!!!!!!!!!!!!")
            if error != nil {
                let answer = self.getAnswerWithoutConnectionManager.showAnswerWithoutConnection()
                self.answerRx.onNext(Answer(text: answer, date: Date()))
                self.answerRx.onError(MyError.unableToComplete)
            }
            guard let data = data else {
                self.answerRx.onError(MyError.invaliData)
                return
            }
            guard let answer = self.parseJSON(withData: data) else {
                self.answerRx.onError(MyError.invaliData)
                return
            }
            self.createAnswerManager.addNewAnswer(answer: answer)
            self.answerRx.onNext(Answer(text: answer, date: Date()))
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
