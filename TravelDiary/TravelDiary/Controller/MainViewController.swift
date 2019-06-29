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
    
    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 3
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let nextOffset: CGFloat = 40
    }
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: view.frame.width, height: view.frame.height - 100 - 80)), collectionViewLayout: layout)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var dao = MemoDAO()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTopView()
        configureConstraints()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 코어 데이터에 저장된 데이터를 가져온다
        self.appDelegate.memolist = self.dao.fetch()
        self.collectionView.reloadData()
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
        collectionView.delegate = self
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
    
    // MARK: - Action Method
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        let current = layout.scrollDirection
        layout.scrollDirection = (current == .horizontal) ? .vertical : .horizontal
        configureFlowLayout()
    }
    
}

// MARK: - extension collectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = self.appDelegate.memolist.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼냄
        let item = self.appDelegate.memolist[indexPath.item]
        
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        // memoCell의 내용을 구성
        cell.configureCellContent(image: item.image, title: item.title)
        cell.tag = indexPath.item
        
        return cell
    }
}

// MARK: - extension collectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let item = self.appDelegate.memolist[indexPath.item]
        detailVC.savedData = item
        show(detailVC, sender: nil)
    }
}
