//
//  ImagesViewModel.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 05/08/2023.
//

import Combine
import Foundation

protocol ImagesViewModelDelegate:AnyObject{
    func didSelectImage(image:PhotoViewModel)
}

//MARK:- ViewModel
class ImagesViewModel{
    private let service:NetworkServiceProtocol
    private var cancenables = Set<AnyCancellable>()
    private var output = PassthroughSubject<Output,Never>()
    
    var banners:[Banner] = []
    private var page:Int = 1
    private var isHasMorePages:Bool = true
    var isLoading:Bool = false

    weak var delegate:ImagesViewModelDelegate?
    
    //MARK:- Input
    enum Input{
        case viewDidAppear
        case loadMore
        case refreshData
        case viewImage(indexPath:IndexPath)
    }
    
    //MARK:- Output
    enum Output{
        case didFailWithError(error:Error)
        case isLoading(loading:Bool)
        case didGetData
    }
    

    init(service: NetworkServiceProtocol = NetworkService.default) {
        self.service = service
    }
    
    
    func transform(input:AnyPublisher<Input,Never>)->AnyPublisher<Output,Never>{
        input
            .sink { [weak self] event in
                guard let self = self else{return}
            switch event{
            case .refreshData,.viewDidAppear:
                self.resetPage()
                self.getImages()
            case .loadMore:
                self.incrementPage()
                self.getImages()
            case .viewImage(let indexPath):
                self.delegate?.didSelectImage(image: self.banners[indexPath.section].photosData[indexPath.item])
            }
        }
        .store(in: &cancenables)
        return output.eraseToAnyPublisher()
    }
    
    func getImages(){
        if isHasMorePages == false || isLoading{
            print("No Load more")
            self.isLoading = false
            return
        }
        self.isLoading = true
        output.send(.isLoading(loading: true))
        let endPoint = FilkerImagesEndPoints.getImages(page: page)
        service.execute(endPoint, model: FilkerResponse.self) { [weak self] result in
            self?.output.send(.isLoading(loading: false))
            self?.isLoading = false
            switch result{
            case .success(let response):
                self?.handleSuccessResponse(response: response)
            case .failure(let error):
                self?.output.send(.didFailWithError(error: error))
            }
        }.store(in: &cancenables)
    }
    
    private func handleSuccessResponse(response:FilkerResponse){
        if response.photos?.pages ?? 1 <= self.page{
            self.isHasMorePages = false
        }
        print("Current Page : \(self.page) , pages \(response.photos?.pages)")
        if self.page == 1{
            self.banners = []
        }
        if let photos = response.photos?.photo , photos.isEmpty == false{
            let photosViewModel = photos.map({
                PhotoViewModel(photo: $0)
            })
            self.banners.append(contentsOf: self.splitArray(array: photosViewModel, subSize: 5))
        }
        self.output.send(self.banners.isEmpty ? .didFailWithError(error: AppErrors.noDataFound) : .didGetData)
    }
        
    private func incrementPage(){
        self.page += 1
    }
    
    private func resetPage(){
        self.page = 1
    }
    
    private func splitArray(array: [PhotoViewModel], subSize: Int) -> [Banner] {
        var dataArray = array
        var result: [Banner] = []

        while !dataArray.isEmpty {
            let subArray: [PhotoViewModel] = Array(dataArray[0..<subSize])
            result.append(Banner(photosData: subArray))
            dataArray.removeSubrange(0..<subSize)
        }
        
        return result
    }
    
}

