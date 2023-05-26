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
    
    var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        thumbnailImage.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
 
    @IBAction func LearnMoreBtnPressed(_ sender: Any) {
        guard let url = URL(string: framework.urlString) else { return }
        
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}
