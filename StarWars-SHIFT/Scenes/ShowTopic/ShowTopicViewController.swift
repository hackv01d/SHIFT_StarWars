//
//  ShowTopicViewController.swift
//  StarWars-SHIFT
//
//  Created by Ivan Semenov on 31.01.2023.
//

import UIKit

final class ShowTopicViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let loadingIndicator = UIActivityIndicatorView()
    lazy private var contentCollection: UICollectionView = {
        let layout = ContentLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let viewModel: ShowTopicViewModel
    private let dataSource: ShowTopicDataSource
    
    // MARK: - Inits
    
    init(viewModel: ShowTopicViewModel) {
        self.viewModel = viewModel
        dataSource = .init(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = viewModel.getNameTopic()

        setup()
        dataSource.configure(with: contentCollection)
        bindToViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButtonItem()
    }
    
    //  MARK: - Setup
    
    private func setup() {
        setupSuperView()
        setupLoadingIndicator()
        setupContentCollection()
    }
    
    private func setupSuperView() {
        guard let backgroundImage = UIImage(named: "space") else { return }
        view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func setupContentCollection() {
        view.addSubview(contentCollection)
        
        contentCollection.showsVerticalScrollIndicator = false
        contentCollection.backgroundColor = .clear
        contentCollection.clipsToBounds = true
        
        contentCollection.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        
        loadingIndicator.color = .appYellow
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
        loadingIndicator.center = view.center
    }
    
    private func setupBackBarButtonItem() {
        let backBarButtonItem = UIBarButtonItem(title: viewModel.getNameTopic(), style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .appYellow
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

// MARK: - Building ViewModel

private extension ShowTopicViewController {
    func bindToViewModel() {
        viewModel.updateCollectionData = { [weak self] in
            self?.contentCollection.reloadData()
            self?.loadingIndicator.stopAnimating()
        }
        
        viewModel.goToDescriptionScreen = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewModel.showReceivedError = { [weak self] error in
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            self?.present(alertController, animated: true)
        }
    }
}
