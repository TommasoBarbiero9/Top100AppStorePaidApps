//
//  DetailViewController.swift
//  VeganApp
//
//  Created by Tommaso Barbiero on 11/07/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var appStoreButton: UIButton!
    @IBOutlet weak var navItem: UINavigationController!
    
    // MARK: - Selected App
    var app : Entry?
    
    
    // MARK: - View Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "AccentColor")
        
        nameLabel.text = app?.name.label
        
        summaryLabel.text = app?.summary.label
        
        
        appStoreButton.setTitle(app?.price.label, for: .normal)
        appStoreButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        appStoreButton.layer.masksToBounds = true
        appStoreButton.layer.cornerRadius = 13
        
        
        iconImageView.downloaded(from: app!.image[2].label)
    }
    
   
    // MARK: - Button Function
    @objc func buttonAction() {
        
        if let url = URL(string: (app?.id.label)!) {
                UIApplication.shared.open(url)//could have made so the link directed straight to the App Store on real device
        }
    }
}
