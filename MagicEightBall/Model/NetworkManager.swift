//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit

protocol DBService {
    func showAnswerWithoutConnection() -> String
}

protocol NetworkService {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL () -> Void
    func parseJSON(withData data: Data ) -> String?
    var dataBaseDelegate: DBService! { get set }
}

// Manager for working with network

class NetworkManager: NetworkService {
    
    /// Handles an instance of String type in case of unsuccessful internet connection
    var completionHandler: ((String) -> Void)?
    
    /// Shows answers from DB in case of unsuccessful internet connection
    var dataBaseDelegate: DBService!
    
    
    //MARK: - Getting data from Network
    
    
    ///Receiving data from the Internet using URLSession
    ///
    /// The function uses url to receive data, response and error using the URLSession where an instance of ViewController is created on the main queue and receives an instance of the String type from there and is handler by the complitionHandler
    ///
    /// - Returns: The function returns Void, but calls the function URLSession
    func fetchAnswerByURL() {
        //The address where the data is received
        let urlString = "https://8ball.delegator.com/magic/JSON/%3Cquestion_string%3E"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let _ = error {
                
                DispatchQueue.main.async {
                    let answer = self.dataBaseDelegate.showAnswerWithoutConnection()
                    self.completionHandler?(answer)
                }
            }
            if let data = data {
                if let answer = self.parseJSON(withData: data) {
                    self.completionHandler?(answer)
                }
            }
        }.resume()
    }
    
    //MARK: - Parsing JSON data
    
    ///Parses JSON data
    ///
    /// Use data formatted Data to get an optional string formatted answer. In the case of an error, it will be printed in the terminal.
    ///
    /// - Returns: Optional String
    func parseJSON(withData data: Data ) -> String? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(DecodedData.self, from: data)
            return decodedData.magic.answer
        } catch{
            print(error)
        }
        return nil
    }
}
