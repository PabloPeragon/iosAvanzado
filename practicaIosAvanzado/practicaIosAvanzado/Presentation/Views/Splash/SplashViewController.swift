//
//  SplashViewController.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import UIKit

final class SplashViewController: UIViewController {
    @IBOutlet weak var splashActivityIndicator: UIActivityIndicatorView!
    
    private var secureData: SecureDataProtocol
    
    
    init(secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.secureData = secureData
        super.init(nibName: String(describing: SplashViewController.self), bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var destination: UIViewController
        splashActivityIndicator.startAnimating()
        if let token = secureData.getToken() {
            destination = HeroesViewController()
            splashActivityIndicator.stopAnimating()
        } else {
            destination = LoginViewController()
            
            }
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        splashActivityIndicator.stopAnimating()
    }
    
}
