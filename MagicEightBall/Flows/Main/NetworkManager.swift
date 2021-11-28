//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
//    MARK: - Protocol
protocol NetworkService {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL(completion: @escaping (_ answer: String?) -> Void)
}
//    MARK: - Class
class NetworkManager: NetworkService {
    /// Handles an instance of String type in case of unsuccessful internet connection
    var completionHandler: ((String) -> Void)?
    /// Shows answers from DB in case of unsuccessful internet connection
    private var dbManager: CreateAnswerProtocol & GetAnswerFromDBProtocol
    init(dbManager: CreateAnswerProtocol & GetAnswerFromDBProtocol) {
        self.dbManager = dbManager
    }
    // MARK: - Getting data from Network
    /// Receiving data from the Internet using URLSession
    /// The function uses url to receive data, response and error using the URLSession
    /// where an instance of ViewController is created on the main queue and receives an instance of the String type
    /// from there and is handler by the complitionHandler
    /// - Returns: The function returns Void, but calls the function URLSession
    func fetchAnswerByURL(completion: @escaping (_ answer: String?) -> Void) {
        // The address where the data is received
        let urlString = L10n.url
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, _, error in
                if error != nil {
                    let answer = self.dbManager.showAnswerWithoutConnection()
                    completion(answer)
                }
                if let data = data {
                    if let answer = self.parseJSON(withData: data) {
                        completion(answer)
                        self.dbManager.createEntity(text: answer)
                    }
                }
            }.resume()
        } else {
            let answer = self.dbManager.showAnswerWithoutConnection()
            completion(answer)
        }
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
