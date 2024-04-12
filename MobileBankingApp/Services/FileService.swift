//
//  DataService.swift
//  MobileBankingApp
//
//  Created by Miran Mendelski on 11.04.2024..
//

import UIKit


protocol FileServiceProtocol: AnyObject {
    
    func decodeJson<T>(completionHandler: @escaping (Result<T, Error>)-> Void)  where T: Decodable
    
}


final class FileService: FileServiceProtocol {
    
    
    func decodeJson<T>( completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        let decoder = JSONDecoder()
        
        if let url = Bundle.main.url(forResource: "accounts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let userData = try decoder.decode(T.self, from: data)
                completionHandler(.success(userData))
            } catch {
                print("Error decoding JSON: \(error)")
                completionHandler(.failure(error))
            }
        } else {
            print("JSON file not found")
        }
   
    }
}
