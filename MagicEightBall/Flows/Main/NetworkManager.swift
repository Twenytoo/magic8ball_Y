//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
// MARK: - Protocol
protocol NetworkService {
    func fetchAnswerByURL(completion: @escaping (Result<String, Error>) -> Void)
}
// MARK: - Class
class NetworkManager: NetworkService {
    /// Handles an instance of String type in case of unsuccessful internet connection
    var completionHandler: ((String) -> Void)?
    /// Shows answers from DB in case of unsuccessful internet connection
    private var createAnswerManager: CreateAnswerProtocol
    private var getAnswerWithoutConnectionManager: GetAnswerFromDBProtocol
    init(createAnswerManager: CreateAnswerProtocol,
         getAnswerWithoutConnectionManager: GetAnswerFromDBProtocol) {
        self.createAnswerManager = createAnswerManager
        self.getAnswerWithoutConnectionManager = getAnswerWithoutConnectionManager
    }
    // MARK: - Getting data from Network
    /// Receiving data from the Internet using URLSession
    /// The function uses url to receive data, response and error using the URLSession
    /// where an instance of ViewController is created on the main queue and receives an instance of the String type
    /// from there and is handler by the complitionHandler
    /// - Returns: The function returns Void, but calls the function URLSession
    func fetchAnswerByURL(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: L10n.url) else {
            let answer = self.getAnswerWithoutConnectionManager.showAnswerWithoutConnection()
                completion(.success(answer))
            return
        }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    if let answer = self?.getAnswerWithoutConnectionManager.showAnswerWithoutConnection() {
                        completion(.success(answer))
                    }
                    completion(.failure(error))
                }
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                guard let answer = self?.parseJSON(withData: data) else {
                    completion(.failure(error!))
                    return
                }
                self?.createAnswerManager.addNewAnswer(answer: answer)
                completion(.success(answer))
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
