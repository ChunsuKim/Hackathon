//
//  ViewController.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 25/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit
import YPImagePicker
import Photos

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let topNavigationView = UIView()
    private let refreshButton = UIButton()
    private let titleLabel = UILabel()
    var selectedItems = [YPMediaItem]()
    
    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 3
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let nextOffset: CGFloat = 40
    }
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: view.frame.width, height: view.frame.height - 100)), collectionViewLayout: layout)
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTopView()
        configureConstraints()
        configureCollectionView()
    }
    
    // MARK: - configuration UserInterface
    private func configureTopView() {
        topNavigationView.backgroundColor = .white
        
        refreshButton.setImage(UIImage(named: "changeView"), for: .normal)
        refreshButton.addTarget(self, action: #selector(changeCollectionViewDirection(_:)), for: .touchUpInside)
        
        titleLabel.text = "Travel Log"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Snell Roundhand", size: 30)
        titleLabel.textColor = #colorLiteral(red: 0.2030595243, green: 0.5943211913, blue: 0.859213531, alpha: 1)
        
        view.addSubview(topNavigationView)
        topNavigationView.addSubview(refreshButton)
        topNavigationView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        topNavigationView.translatesAutoresizingMaskIntoConstraints = false
        topNavigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topNavigationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.centerYAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: topNavigationView.trailingAnchor, constant: -20).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topNavigationView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 95).isActive = true
    }
    
    // MARK: - configuration collectionView
    private func configureCollectionView() {
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        configureFlowLayout()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        configureFlowLayout()
    }
    
    // MARK: - configuration collectionView FlowLayout
    private func configureFlowLayout() {
        layout.minimumInteritemSpacing = UI.itemSpacing
        layout.minimumLineSpacing = UI.lineSpacing
        layout.sectionInset = UI.edgeInsets
        
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom + topNavigationView.safeAreaInsets.top + view.safeAreaInsets.bottom
        
        if layout.scrollDirection == .vertical {
            let horizontalSpacing = itemSpacing + horizontalInset
            let width = (collectionView.frame.width - horizontalSpacing) / UI.itemsInLine
            let rounded = width.rounded(.down)
            layout.itemSize = CGSize(width: rounded, height: rounded)
        } else {
            let verticalSpacing = itemSpacing + verticalInset
            let height = (collectionView.frame.height - verticalSpacing) / UI.itemsInLine
            let rounded = height.rounded(.down)
            layout.itemSize = CGSize(width: rounded, height: rounded)
        }
    }
    
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        let current = layout.scrollDirection
        layout.scrollDirection = (current == .horizontal) ? .vertical : .horizontal
        configureFlowLayout()
    }
    
    @objc private func writeButtonDidTap(_ sender: UIButton) {
        let writeViewController = WriteViewController()
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.showsCrop = .rectangle(ratio: 16/15)
        config.wordings.libraryTitle = "Travel Log"
        config.library.maxNumberOfItems = 5
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            
            self.selectedItems = items
            writeViewController.selectedImageView.image = items.singlePhoto?.image
            picker.dismiss(animated: true) {
                self.present(writeViewController, animated: false)
            }
        }
        present(picker, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.configureCellContent(image: UIImage(named: "default"), title: "잠실야경")
        
//        cell.backgroundColor = #colorLiteral(red: 0.2071147859, green: 0.5941259265, blue: 0.8571158051, alpha: 1)
        
        return cell
    }
    
    
}

