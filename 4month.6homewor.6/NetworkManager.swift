//
//  NetworkManager.swift
//  4month.6homewor.6
//
//  Created by акрам on 18/1/23.
//

import Foundation


class NetworkManager {
    func parse(completion: @escaping (MemeState?) -> Void) {
        let urlPath = "https://api.imgflip.com/get_memes"
        
        
        guard let url = URL(string: urlPath) else {
            print("Неполучилось")
            return
        }
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("Пусто")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("успех")
                } else {
                    print(httpResponse.statusCode)
                }
            }
            
            guard error == nil else {
                print("ошибка! \(error!.localizedDescription)")
                return
            }
            
            
            do {
                let memeState = try JSONDecoder().decode(MemeState.self, from: data)
                completion(memeState)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        
        task.resume()
    }
}

