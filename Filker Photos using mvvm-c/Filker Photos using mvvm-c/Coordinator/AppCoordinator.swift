//
//  AppCoordinator.swift
//  mvvm-c
//
//  Created by Sherif Hamdy on 04/08/2023.
//

import UIKit

class AppCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    
    private let window:UIWindow

    lazy var rootViewCoordinator:UINavigationController = {
        return UINavigationController()
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = rootViewCoordinator
        window.makeKeyAndVisible()
        homeFlow()
    }
    
    private func homeFlow(){
        let homeCoordinator = HomeCoordinator(navigationController: self.rootViewCoordinator)
        self.store(coordinator: homeCoordinator)
        homeCoordinator.start()
    }
    
    
}


