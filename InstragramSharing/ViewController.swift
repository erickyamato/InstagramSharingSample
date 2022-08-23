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
    
    // MARK: - Private Vars
    private let instagramFormats = InstagramFormats.shared
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyText()
        applyImage()
    }
    
    // MARK: - Private Functions
    private func applyText() {
        shareButton.setTitle(Constants.kShareButtonTitle, for: .normal)
    }
    
    private func applyImage() {
        guard let shareImage = UIImage(systemName: "square.and.arrow.up") else { return }
        
        shareButton.setImage(shareImage, for: .normal)
        shareButton.semanticContentAttribute = .forceRightToLeft
    }

    // MARK: - Actions
    @IBAction func didTapShareButton(_ sender: Any) {
        instagramFormats.postImageToStories(backgroundImage: UIImage(systemName: "gear")!)
    }
    
    
    
}

