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
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureActivityIndictor()
        // Do any additional setup after loading the view.
    }
    
    private func configureActivityIndictor(){
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .red
        activityIndicator.style = .large
    }

}
