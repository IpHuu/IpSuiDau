//
//  Network.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation

class Network<T: Decodable>{
    static func request(api: APIType, completion: @escaping(APIResponse<T>?, APIError?) -> Void){
        guard let url = URL(string: api.url) else {
            completion(nil, APIError.invalidURL)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, APIError.networkError(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, APIError.invalidResponse)
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(nil, APIError.statusCode(httpResponse.statusCode))
                return
            }
            guard let data = data else {
                completion(nil, APIError.invalidData)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(APIResponse<T>.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, APIError.jsonParsingError(error))
            }
        }
        
        task.resume()
    }
}
