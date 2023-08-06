//
//  HomeVC.swift
//  Filker Photos using mvvm-c
//
//  Created by Sherif Hamdy on 06/08/2023.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    //MARK:- CollectionView Attributes
    let spacing:CGFloat = 15
    let itemsPerRow:CGFloat = 2
    lazy var availableWidth = collectionView.frame.width - (spacing * 2) - (spacing*(itemsPerRow-1)/2)
    lazy var itemWidth = availableWidth / 2
    
    //MARK:- typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Banner, PhotoViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Banner, PhotoViewModel>
    
    internal lazy var dataSource = makeDataSource()
    
    let input = PassthroughSubject<ImagesViewModel.Input,Never>()
    private var cancenables = Set<AnyCancellable>()
    
    //MARK:- ViewModel
    private var viewModel:ImagesViewModel

    init(viewModel: ImagesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureActivityIndictor()
        bindData()
        input.send(.viewDidAppear)

        // Do any additional setup after loading the view.
    }
    
    private func bindData(){
        viewModel.transform(input: input.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] output in
                switch output{
                case .didFailWithError(let error):
                    self?.showDefaultAlert(title: "Error", message: error.localizedDescription)
                case .didGetData:
                    self?.applySnapshot(animatingDifferences: false)
                    //self?.collectionView.checkData(emptyError: nil)
                case .isLoading(let loading):
                    if loading{
                        self?.activityIndicator.startAnimating()
                    }else{
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }.store(in: &cancenables)
    }
    
    private func configureActivityIndictor(){
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .red
        activityIndicator.style = .large
    }

}

extension HomeVC{
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(viewModel.banners)
        viewModel.banners.forEach { section in
            snapshot.appendItems(section.photosData, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
