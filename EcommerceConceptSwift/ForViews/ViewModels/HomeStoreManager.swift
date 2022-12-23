//
//  HomeStoreManager.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 15/12/22.
//

import Foundation
import UIKit

struct HomeStoreManager{
    func fetchHomeData(completion: @escaping(HomeModel) -> Void){
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else {return }
        let dataTask = URLSession.shared.dataTask(with: url){data,_, error in
            if let error = error {
                print("Error fetch home data \(error.localizedDescription)")
            }
            guard let jsonData = data else{return}
            let decoder = JSONDecoder()
            do{
                let decodeData = try decoder.decode(HomeModel.self, from: jsonData)
                print(decodeData)
                completion(decodeData)
            }catch{
                print("Error decoder data")
            }
        }
        dataTask.resume()
    }
}
