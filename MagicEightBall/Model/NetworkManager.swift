//
//  NetworkManager.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import Foundation

struct NetworkManager {
    
    var completionHandler: ((String)->Void)?
    
    func fetchAnswer () {
        let urlString = "https://8ball.delegator.com/magic/JSON/%3Cquestion_string%3E"
        guard let url = URL(string: urlString) else {
            return
            //ДОПИСАТЬ ЛОГИКУ ЕСЛИ НЕТ ИНТЕРНЕТА
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print(error)
                return
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
