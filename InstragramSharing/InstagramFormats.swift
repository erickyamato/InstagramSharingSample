//
//  InstagramFormats.swift
//  InstragramSharing
//
//  Created by Erick Yamato on 19/08/22.
//

import UIKit

class InstagramFormats: NSObject {
    
    static let shared = InstagramFormats()
    
    // MARK: - Constants
    private enum Constants {
        static let kURLScheme = "instagram-stories://share"
    }
    
    // MARK: - Enum
    enum optionnKey: String {
        case stickerImage = "com.instagram.sharedSticker.stickerImage"
        case backgroundImage = "com.instagram.sharedSticker.backgroundImage"
        case backgroundVideo = "com.instagram.sharedSticker.backgroundVideo"
        case backgroundTopColor = "com.instagram.sharedSticker.backgroundTopColor"
        case backgroundBottomColor = "com.instagram.sharedSticker.backgroundBottomColor"
        case contentUrl = "com.instagram.sharedSticker.contentURL"
    }
    
    // MARK: - Public Functions
    func postImageToStories(backgroundImage: UIImage,
                            stickerImage: UIImage? = nil,
                            conntentURL: String? = nil) -> Bool {
        var items:  [[String: Any]] = [[:]]
        
        if let backgroundImageData = backgroundImage.pngData() {
            items[0].updateValue(backgroundImageData, forKey: optionnKey.backgroundImage.rawValue)
        }
        
        if stickerImage != nil {
            if let stickerImageData = stickerImage?.pngData() {
                items[0].updateValue(stickerImageData, forKey: optionnKey.stickerImage.rawValue)
            }
        }
        
        if conntentURL != nil {
            items[0].updateValue(conntentURL as Any, forKey: optionnKey.contentUrl.rawValue)
        }
        
        let isPosted = post(items)
        
        return isPosted
    }
    
    func postVideoToStories(backgroundVideoURL: URL,
                            stickerImage: UIImage? = nil,
                            contentURL: String? = nil) -> Bool {
        var items: [[String: Any]] = [[:]]
        
        var backgroundVideoData: Data?
        do {
            try backgroundVideoData = Data(contentsOf: backgroundVideoURL)
        } catch {
            return false
        }
        
        guard let backgroundVideoData = backgroundVideoData else { return false }

        
        items[0].updateValue(backgroundVideoData as Data, forKey: optionnKey.backgroundVideo.rawValue)
        
        if stickerImage != nil {
            if let stickerImageData = stickerImage?.pngData() {
                items[0].updateValue(stickerImageData, forKey: optionnKey.stickerImage.rawValue)
            }
        }
        
        if contentURL != nil {
            items[0].updateValue(contentURL as Any, forKey: optionnKey.contentUrl.rawValue)
        }
        
        let isPosted = post(items)
        
        return isPosted
    }
    
    func postStickerToStories(stickerImage: UIImage,
                              backgroundTopColor: String = "#000000",
                              backgroundBottomColor: String = "#000000",
                              contentURL: String? = nil) -> Bool {
        var items: [[String: Any]] = [[:]]
        
        if let stickerImageData = stickerImage.pngData() {
            items[0].updateValue(stickerImageData, forKey: optionnKey.stickerImage.rawValue)
            items[0].updateValue(backgroundTopColor, forKey: optionnKey.backgroundTopColor.rawValue)
            items[0].updateValue(backgroundBottomColor, forKey: optionnKey.backgroundBottomColor.rawValue)
        }
        
        if contentURL != nil {
            items[0].updateValue(contentURL as Any, forKey: optionnKey.contentUrl.rawValue)
        }
        
        let isPosted = post(items)
        
        return isPosted
    }
    
    // MARK: - Private Function
    private func post(_ items: [[String: Any]]) -> Bool {
        
        guard let urlScheme = URL(string:Constants.kURLScheme) else { return false }
        
        guard UIApplication.shared.canOpenURL(urlScheme) else {
            return false
        }
            
        let options: [UIPasteboard.OptionsKey: Any] = [.expirationDate: Date().addingTimeInterval(60 * 5)]
        UIPasteboard.general.setItems(items, options: options)
        UIApplication.shared.open(urlScheme)
        return true
    }
}
