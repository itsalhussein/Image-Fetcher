//
//  PhotoDetailVC.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 03/11/2022.
//

import UIKit

class PhotoDetailVC: UIViewController, UIScrollViewDelegate {
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties

    private var viewModel : PhotoDetailViewModel
    
    //MARK: - Init and Life cycle
    
    init(viewModel:PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        viewModel.setImageView(imageURL: viewModel.imageURL, image: imageView)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
