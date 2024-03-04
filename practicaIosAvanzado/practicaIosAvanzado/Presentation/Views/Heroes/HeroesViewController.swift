//
//  HeroesViewController.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 2/3/24.
//

import UIKit

class HeroesViewController: UIViewController {
    
    private var secureData: SecureDataProtocol

    init(secureData: SecureDataProtocol = SecureDataKeychain()) {
        self.secureData = secureData
        super.init(nibName: String(describing: HeroesViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true


        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        secureData.deleteToken()
        navigationController?.popToRootViewController(animated: true)
    }
}
