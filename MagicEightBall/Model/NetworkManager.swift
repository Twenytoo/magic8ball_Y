//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit

struct NetworkManager {
    
    var completionHandler: ((String)->Void)?
    
    
    func fetchAnswer () {
        let urlString = "https://8ball.delegator.com/magic/JSON/%3Cquestion_string%3E"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    let sc = ViewController()
                    let answer = sc.showAnswerWithoutConnection()
                    self.completionHandler?(answer)
                }
            }
            if let data = data {
                if let answer = parseJSON(withData: data) {
                    self.completionHandler?(answer)
                }
            }
        }.resume()
    }
    
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
