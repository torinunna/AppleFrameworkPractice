//
//  FrameworkListViewController.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/05/21.
//

import UIKit

class FrameworkListViewController: UIViewController {
    
    let list: [AppleFramework] = AppleFramework.list
    
    // UICollectionViewDiffableDataSource -> presentation
    enum Section {
        case main
    }
    typealias Item = AppleFramework
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrameworkCell.identifier, for: indexPath) as? FrameworkCell else { return nil }
            cell.configure(item)
            return cell
        })
        
        // snapshot -> data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
    }
    
    // compositional layout -> layout
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
