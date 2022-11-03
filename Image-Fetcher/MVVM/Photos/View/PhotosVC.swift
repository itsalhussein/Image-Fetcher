//
//  PhotosVC.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 01/11/2022.
//

import UIKit

class PhotosVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties

    private var viewModel = PhotosViewModel()
    
    //MARK: - Init and Life cycle
    
    init(viewModel:PhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureBinding()
        viewModel.fetchPhotos(startIndex: 0)
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(PhotoCell.nib, forCellReuseIdentifier: PhotoCell.identifier)
    }
    
    func configureBinding(){
        viewModel.photosFetchedClosure = { 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.reloadTableView = {
            
        }
    }
}

extension PhotosVC : UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        let cellData = viewModel.getPhotoItem(at: indexPath)
        cell.photo = cellData
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPhotosCount()
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if (index.row >= viewModel.photos.count - 3) && !(viewModel.isFetchingImages) {
                viewModel.fetchPhotos(startIndex: viewModel.startIndex)
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(viewModel.getPhotoItem(at: indexPath))")
    }
}

