//
//  BabyNamesService.swift
//  BabyNameGeneratorApp
//
//  Created by Eduardo Maia on 18/01/23.
//

import Foundation

protocol BabyNamesServiceProtocol {
    func fetchBabyList(completion: @escaping ([Baby], String) -> Void)
}

class BabyNamesService : BabyNamesServiceProtocol {
    func fetchBabyList(completion: @escaping ([Baby], String) -> Void) {
        let url = URL(string: ConstantsHelper.endpointAPI)!
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion([], "\(error)")
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion([], "ERROR")
            } else {
                let decoder = JSONDecoder()

                if let data = data, let namesList = try? decoder.decode([Baby].self, from: data) {
                    completion(namesList, "")
                } else {
                    completion([], "ERROR")
                }
            }
        }).resume()
    }
}
