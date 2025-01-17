//
//  DetailsCoordinator.swift
//  StarWars-SHIFT
//
//  Created by Ivan Semenov on 02.08.2023.
//

import UIKit

final class DetailsCoordinator: BaseCoordinator, AlertPresentable {
    
    private let detailsData: DetailsViewModelData
    
    init(navigationController: UINavigationController, dependencyContainer: DependencyContainer, detailsData: DetailsViewModelData) {
        self.detailsData = detailsData
        super.init(navigationController: navigationController, dependencyContainer: dependencyContainer)
    }
    
    override func start() {
        let viewModel = DetailsViewModel(factory: dependencyContainer, detailsData: detailsData, isOptional: false)
        let viewController = DetailsViewController(with: viewModel)
        
        viewModel.didPresentOptionDetails = { [weak self] detailsData in
            self?.presentDetailsScene(detailsData: detailsData)
        }
        
        viewModel.showReceivedError = { [weak self] description in
            self?.presentErrorAlert(with: description)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - Navigation

private extension DetailsCoordinator {
 
    func presentDetailsScene(detailsData: DetailsViewModelData) {
        let viewModel = DetailsViewModel(factory: dependencyContainer, detailsData: detailsData, isOptional: true)
        let viewController = DetailsViewController(with: viewModel)
        
        let navController = UINavigationController(rootViewController: viewController)
        navigationController.present(navController, animated: true)
    }
    
}
