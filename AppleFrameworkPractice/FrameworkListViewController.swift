//
//  FrameworkListViewController.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/05/21.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // UICollectionViewDiffableDataSource -> presentation
    enum Section {
        case main
    }
    typealias Item = AppleFramework
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    //    Combine
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    let items = CurrentValueSubject<[AppleFramework], Never>(AppleFramework.list)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        bind()
    }
    
    private func bind() {
        //        input
        didSelect
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
                let storyboard = UIStoryboard(name: "Detail", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
                vc.framework = framework
                self.present(vc, animated: true)
            }.store(in: &subscriptions)
        
        //        ouptut
        items
            .receive(on: RunLoop.main)
            .sink { [unowned self] list in
                applySectionItems(list)
            }.store(in: &subscriptions)
    }
    
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        datasource.apply(snapshot)
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrameworkCell.identifier, for: indexPath) as? FrameworkCell else { return nil }
            cell.configure(item)
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
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

extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = items.value[indexPath.item]
        didSelect.send(framework)
    }
}
