//
//  PhotoCell.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 03/11/2022.
//

import UIKit
import SDWebImage

class PhotoCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var cellPhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 24
        cellPhoto.clipsToBounds = true
        selectionStyle = .none
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String.init(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: String.init(describing: self), bundle: nil)
    }
    
    var photo : PhotoResponseModel! {
        didSet {
            setCellData()
        }
    }
    
    //MARK: - Methods
    
    private func setCellData(){
        guard let pic = photo.url else { return }
        let transformer = SDImageResizingTransformer(size: CGSize(width: self.cellPhoto.frame.width, height: self.cellPhoto.frame.height), scaleMode: .fill)
        self.cellPhoto.sd_setImage(with: URL(string: pic), placeholderImage: UIImage(named: "ic_temp"), context: [.imageTransformer: transformer])
        titleLabel.text = photo.title
    }

 
    
}
