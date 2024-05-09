//
//  ImageLoader.swift
//  IpSuiDau
//
//  Created by Ipman on 09/05/2024.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let urlSession = URLSession(configuration: .default)
    
    private init() {}
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            completion(UIImage(data: cachedResponse.data))
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(nil)
                return
            }
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: URLRequest(url: url))
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }.resume()
    }
}
