//
//  PhotosViewModel.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 03/11/2022.
//

import Foundation

class PhotosViewModel {
    //MARK: - Properties
    var photosFetchedClosure: (()->())?
    var isFetchingImages = false
    var reloadTableView : (()->())?
    private var photosAPI: ApiClientProtocol
    var startIndex = 0
    var photos : [PhotoResponseModel] = [] {
        didSet {
            reloadTableView?()
        }
    }

    //MARK: - init
    init(photosAPI: ApiClientProtocol = ApiClient()) {
        self.photosAPI = photosAPI
    }
    
    //MARK: - Methods
    func getPhotoItem(at index: IndexPath) -> PhotoResponseModel {
        return self.photos[index.row]
    }
    
    func getPhotosCount() -> Int {
        return self.photos.count 
    }

    //MARK: - API Call

    func fetchPhotos(startIndex: Int ){
        let request = PhotoRequestModel.init(_start: startIndex, _limit: 10)
        self.isFetchingImages = true
        photosAPI.sendRequest(Api.photos(request: request), decadoingType: [PhotoResponseModel].self) { result in
            switch result {
            case .success(let response):
                self.photos.append(contentsOf: response)
                self.startIndex += 10
                self.isFetchingImages = false
                self.photosFetchedClosure?()
                print("RESPONSE : -",response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}


