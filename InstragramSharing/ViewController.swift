//
//  ViewController.swift
//  InstragramSharing
//
//  Created by Erick Yamato on 19/08/22.
//

import UIKit

class ViewController: UIViewController {
   
    // MARK: - Constants
    private enum Constants {
        static let kShareButtonTitle = "Compartilhar"
        static let kURLScheme = "instagram-stories://share"
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var shareButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyText()
    }
    
    // MARK: - Private Functions
    private func applyText() {
        shareButton.setTitle(Constants.kShareButtonTitle, for: .normal)
    }

    // MARK: - Actions
    @IBAction func didTapShareButton(_ sender: Any) {
        if let urlScheme = URL(string: Constants.kURLScheme) {
            
            // 2
            if UIApplication.shared.canOpenURL(urlScheme) {
                
                // 3
                let imageData: Data = UIImage(systemName: "doc.fill")!.pngData()!
                
                // 4
                let items = [["com.instagram.sharedSticker.backgroundImage": imageData]]
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                
                // 5
                UIPasteboard.general.setItems(items, options: pasteboardOptions)
                
                // 6
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    
}

