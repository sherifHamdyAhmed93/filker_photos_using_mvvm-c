//
//  HomeCoordinator.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 04/08/2023.
//

import UIKit

class HomeCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    
    private let navigationController:UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let vc = homeVC{
            navigationController.setViewControllers([vc], animated: true)
        }
    }
    
    lazy var homeVC:HomeVC? = {
        let vm = ImagesViewModel()
        vm.delegate = self
        let vc = HomeVC(viewModel: vm)
       return vc
    }()
}

extension HomeCoordinator:ImagesViewModelDelegate{
    func didSelectImage(image: PhotoViewModel) {
        let vc = ImageViewController(photoViewModel: image)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
