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
            if error != nil {
                completion([], NSLocalizedString("internet_error", comment: ""))
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion([], NSLocalizedString("request_error", comment: ""))
            } else {
                let decoder = JSONDecoder()

                if let data = data, let namesList = try? decoder.decode([Baby].self, from: data) {
                    completion(namesList, "")
                } else {
                    completion([], NSLocalizedString("parse_error", comment: ""))
                }
            }
        }).resume()
    }
}
