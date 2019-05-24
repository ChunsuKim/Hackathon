//
//  ListViewController.swift
//  Dairy
//
//  Created by 차수연 on 21/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
  var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubview()
    autoLayout()
    configure()
    
  }
  
  private func addSubview() {
    view.addSubview(collectionView)
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    collectionView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    collectionView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.9).isActive = true
    
  }
  
  private func configure() {
    collectionView.backgroundColor = .white
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    
    collectionView.showsHorizontalScrollIndicator = true
    collectionView.isPagingEnabled = true
    
    
  }
}

extension ListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
    return cell
  }
}

extension ListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
     
    show(detailVC, sender: nil)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.width, height: view.frame.width)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
    
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
    
    return 0
  }
  
  //셀 사이의 간격
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
    
    return 0
  }
}
