//
//  SVGDataFetcher.swift
//  BitPandaUI
//

import Foundation
//import PINCache

// MARK: - SVGDataFetcher

class SVGDataFetcher {

    enum FetcherError: Error {
        case requestFailed
        case dataCorrupted
    }

    func requestData(at _: URL, completion: @escaping (Result<Data, FetcherError>) -> Void) {
//        PINCache.shared.object(forKeyAsync: url.absoluteString) { _, _, object in
//            guard let object = object as? Data else { return }
//            completion(.success(object))
//        }
//        let task = URLSession.shared.dataTask(with: url) { responseData, _, responseError in
//            if responseError != nil {
//                completion(.failure(SVGDataFetcher.FetcherError.requestFailed))
//            } else if let data = responseData {
//
//                PINCache.shared.setObject(data, forKey: url.absoluteString)
//                completion(.success(data))
//            } else {
//                completion(.failure(SVGDataFetcher.FetcherError.dataCorrupted))
//            }
//        }
//
//        task.resume()
        completion(.failure(SVGDataFetcher.FetcherError.dataCorrupted))
    }
}
