//
//  ApiClient.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 13/12/22.
//

import Foundation

class ApiClient {
        
    func sendGetRequest<T: Codable>(url: String, parameters: [String: String]? = nil, completion: @escaping (T?, String?, Error?) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
            }
            
            DispatchQueue.main.async {
                do {
                    if let data = data {
                        let model = try JSONDecoder().decode(T.self, from: data)
                    
                        completion(model, nil, nil)
                    } else {
                        completion(nil, "Error data is nil", error)
                    }
                } catch {
                    completion(nil, "Error convert model", error)
                }
            }
        }.resume()
    }
}
