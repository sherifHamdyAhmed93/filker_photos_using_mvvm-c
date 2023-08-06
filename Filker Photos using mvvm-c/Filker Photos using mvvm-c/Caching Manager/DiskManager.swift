//
//  DiskManager.swift
//  Filker Photos using mvvm-c
//
//  Created by Sherif Hamdy on 06/08/2023.
//

import UIKit

final class DiskManager{
    func loadImageFromDisk(fileName: String, completion: @escaping ImageCompletionHandler) {
            DispatchQueue.global().async {
                let fileURL = self.getDocumentsDirectory().appendingPathComponent(fileName)
                if let imageData = try? Data(contentsOf: fileURL) {
                    let image = UIImage(data: imageData)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    
    func saveImageToDisk(image: UIImage, key: URL) {
        DispatchQueue.global().async {
            if let data = image.jpegData(compressionQuality: 1.0) {
                let fileURL = self.getDocumentsDirectory().appendingPathComponent(key.lastPathComponent)
                do {
                    try data.write(to: fileURL)
                    //print("Image saved successfully at: \(fileURL.path)")
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
