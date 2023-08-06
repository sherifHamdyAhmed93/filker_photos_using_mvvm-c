//
//  CacheManager.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import UIKit

typealias ImageCompletionHandler = (UIImage?) -> Void


final class ImageCacheManager {
    // MARK: - Properties
    
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    private let diskManger = DiskManager()
    
    // MARK: - Caching
    private let lock = NSLock()
    
    private init(){
        cache.totalCostLimit = 1024 * 1024 * 10
        cache.countLimit = 100
    }
    
    func cache(image: UIImage, forKey key: URL) {
        lock.lock(); defer { lock.unlock() }
        cache.setObject(image, forKey: key.absoluteString as NSString)
        diskManger.saveImageToDisk(image: image, key: key)
    }
    
    func image(forKey key: URL,completion: @escaping ImageCompletionHandler) {
        lock.lock(); defer { lock.unlock() }
        if let cachedImage = cache.object(forKey: key.absoluteString as NSString){
            completion(cachedImage)
        }else{
            diskManger.loadImageFromDisk(fileName: key.lastPathComponent, completion:{image in
                completion(image)
            })
        }
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
}



