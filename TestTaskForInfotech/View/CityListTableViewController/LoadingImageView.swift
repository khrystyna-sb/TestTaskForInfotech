//
//  LoadingImageView.swift
//  TestTaskForInfotech
//
//  Created by Roma Test on 26.09.2022.
//

import UIKit

class LoadingImageView: UIImageView {
    private let loadingService: ImageLoadingServiceProtocol = ImageLoadingService.shared
    deinit {
        self.cancelLoading()
    }
    
    func loadImage(mainPath: Path?) {
        guard let mainPath = mainPath else { return }
        self.loadingService.loadImage(mainPath: mainPath) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure:
                self?.image = UIImage(named: "empty")
            }
        }
    }
    
    func cancelLoading() {
        self.image = UIImage(named: "empty")
        self.loadingService.cancelLoading()
    }
}
