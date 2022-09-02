//
//  Webservice.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation

class Webservice {
    // MARK: - Singleton instance
    static let current = Webservice()
    
    // MARK: - Variables
    private var imageCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    // MARK: - Request methods
    func request<T: Decodable>(endpoint: String, type: T.Type, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) async {
        guard let url = URL(string: endpoint) else { return }
        do {
            let task = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type.self, from: task.0)
            onSuccess(decodedData)
        } catch {
            onError(error)
        }
    }
    
    func requestImage(path: String) async -> Data? {
        let endpoint = Config.URL_IMAGE_BASE + path
        guard let url = URL(string: endpoint) else { return nil }
        do {
            if let data = imageCache.object(forKey: NSString(string: path)) {
                return Data(referencing: data)
            } else {
                let task = try await URLSession.shared.data(from: url)
                imageCache.setObject(NSData(data: task.0), forKey: NSString(string: path))
                return task.0
            }
        } catch {
            return nil
        }
    }
    
}
