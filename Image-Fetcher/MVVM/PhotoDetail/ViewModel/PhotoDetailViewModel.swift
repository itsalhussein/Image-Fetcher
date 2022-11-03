//
//  PhotoDetailViewModel.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 03/11/2022.
//

import Foundation
import SDWebImage
import UIKit

class PhotoDetailViewModel {
    
    var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
    
    func setImageView(imageURL : String, image: UIImageView){
        let transformer = SDImageResizingTransformer(size: CGSize(width: image.frame.width, height: image.frame.height), scaleMode: .fill)
        image.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "ic_temp"), context: [.imageTransformer: transformer])
    }
    
}
