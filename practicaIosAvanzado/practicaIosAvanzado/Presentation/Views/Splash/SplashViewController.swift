//
//  SplashViewController.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var splashActivityIndicator: UIActivityIndicatorView!
    
    private var viewModel: SplashViewModel
    
    //MARK: - Inits
    init(viewModel: SplashViewModel = SplashViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        viewModel.simulationLoadData()

    }

}

//MARK: - Extension
extension SplashViewController {
    private func showLoading(show: Bool) {
        switch show {
        case true where !splashActivityIndicator.isAnimating:
            splashActivityIndicator.startAnimating()
        case false where splashActivityIndicator.isAnimating:
            splashActivityIndicator.stopAnimating()
        default: break
        }
    }
    
    private func setObservers() {
        viewModel.modelStatusLoad = { [weak self] status in
            switch status {
                
            case .loading:
                self?.showLoading(show: true)
            case .loaded:
                self?.showLoading(show: false)
                self?.navigateToLogin()
            case .error:
                print("Error Splash")
            case .none:
                print("None Splash")
            }
            
        }
    }
    
    //Metodo privado para navegar al login(siguiente pantalla)
    private func navigateToLogin() {
        let nextVC = LoginViewController()
        //Con el setViewControllers no podemos navegar hacia atras, no saca barra de navegacion
        //para utilizar la barra de navegacion seria pushViewController
        navigationController?.setViewControllers([nextVC], animated: false )
    }
}
