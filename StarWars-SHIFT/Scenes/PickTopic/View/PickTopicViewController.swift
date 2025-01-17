//
//  PickTopicViewController.swift
//  StarWars-SHIFT
//
//  Created by Ivan Semenov on 29.01.2023.
//

import UIKit

final class PickTopicViewController: UIViewController {
    
    // MARK: - Private properties

    private lazy var topicCollection: UICollectionView = {
        let heightOfNavBar = self.navigationController?.navigationBar.bounds.height
        let layout = TopicLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset.top -= (heightOfNavBar ?? 0)
        return collectionView
    }()
    
    private let viewModel: PickTopicViewModel
    private let dataSource: PickTopicDataSource
    
    // MARK: - Inits
    
    init(with viewModel: PickTopicViewModel) {
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
        
        setup()
        dataSource.configure(with: topicCollection)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButtonItem()
    }
    
    //  MARK: - Setup
    
    private func setup() {
        setupSuperView()
        setupTopicCollection()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .spaceBackground
    }
    
    private func setupTopicCollection() {
        view.addSubview(topicCollection)
        
        topicCollection.delegate = self
        topicCollection.backgroundColor = .clear
        topicCollection.showsVerticalScrollIndicator = false
        
        topicCollection.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBackBarButtonItem() {
        let backBarButtonItem = UIBarButtonItem(title: viewModel.sceneTitle, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .appYellow
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

// MARK: - UICollectionViewDelegate

extension PickTopicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.moveToContentListScene(at: indexPath.item)
    }
}
