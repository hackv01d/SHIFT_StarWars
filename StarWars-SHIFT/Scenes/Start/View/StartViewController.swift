//
//  StartViewController.swift
//  StarWars-SHIFT
//
//  Created by Ivan Semenov on 29.01.2023.
//

import UIKit

final class StartViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let label = UILabel()
    private let mainImageView = UIImageView()
    private let continueButton = UIButton(type: .system)
    
    private let viewModel: StartViewModel
    
    // MARK: - Inits
    
    init(with viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButtonItem()
    }
    
    // MARK: - Actions
    
    @objc
    private func handleContinueButton() {
        viewModel.moveToPickTopicScene()
    }
    
    //  MARK: - Setup
    
    private func setup() {
        setupBackBarButtonItem()
        setupSuperView()
        setupMainImageView()
        setupContinueButton()
        setupMainLabel()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBlack
    }
    
    private func setupMainImageView() {
        view.addSubview(mainImageView)
        
        mainImageView.image = UIImage(.starWars)
        mainImageView.contentMode = .scaleAspectFit
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(view.bounds.height/23)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.setImage(UIImage(.rightArrow), for: .normal)
        continueButton.tintColor = .black
        continueButton.backgroundColor = .appYellow
        continueButton.layer.cornerRadius = 30
        continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        
        continueButton.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.bottom.equalToSuperview().inset(view.bounds.height/11)
            make.trailing.equalToSuperview().inset(50)
        }
    }
    
    private func setupMainLabel() {
        view.addSubview(label)
        
        label.text = viewModel.mainTitle
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textColor = .appGray
        label.textAlignment = .center
        label.font = .startLabel
        label.numberOfLines = 2
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    private func setupBackBarButtonItem() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .appYellow
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
