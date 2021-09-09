//
//  ApiService.swift
//  AVITO_JSON
//
//  Created by admin on 09.09.2021.
//  Copyright © 2021 ZanLabEngine. All rights reserved.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    
    let link = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    
    func fetchCompanies(completion: @escaping (ResponseModel) -> ()) {
        guard let url = URL(string: link) else { return }
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: url) { data, _, err in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let model = try jsonDecoder.decode(ResponseModel.self, from: data)
                        DispatchQueue.main.async {
                            completion(model)
                        }
                    } catch {
                        debugPrint("Can not parse model")
                    }
                }
                if let err = err {
                debugPrint(err)
            }
            }.resume()
        }
    }
}
