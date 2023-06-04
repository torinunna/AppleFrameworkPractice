//
//  FrameworkDetailViewController.swift
//  AppleFrameworkPractice
//
//  Created by YUJIN KWON on 2023/05/22.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var subscriptions = Set<AnyCancellable>()
    var viewModel: FrameworkDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.didSelect
            .receive(on: RunLoop.main)
            .compactMap { URL(string: $0.urlString) }
            .sink { [unowned self] url in
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.framework
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
                self.thumbnailImage.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
    }
    
    @IBAction func LearnMoreBtnPressed(_ sender: Any) {
        viewModel.LearnMoreBtnPressed()
    }
}

