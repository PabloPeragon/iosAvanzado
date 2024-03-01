//
//  LoginViewController.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import UIKit

class LoginViewController: UIViewController {
    let defaultBottonConstant = 200.0
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var btnAceptBotton: NSLayoutConstraint!
    
    
    private var viewModel: LoginViewModel
    
    
    //MARK: - Inits
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ocultamso el navigation bar porque no queremos tener opción de navegar Back
        navigationController?.isNavigationBarHidden = true
        viewModel.loginStateChanged = { state in
            //TODO: - Controlar que puede fallar el servicio (Se puede pasar un parámetro estado por ejemplo en loginStateChanged
            
            // Navegamos a Heroes Controller
            DispatchQueue.main.async {
                // Si el login es con exito, navegamos a la pantalal de Heroes
                let heroes = HeroesTableViewController()
                self.navigationController?.pushViewController(heroes, animated: true)
            }
            
        }
    }
        
        
        //MARK: - IBAction
        func onLoginButtonTap(_ sender: Any) {
            viewModel.loginWith(email: emailTextFiled.text ?? "pabloperagon@gmail.com", password: passwordTextField.text ?? "123456")
        }
        
        
}
    
    /*
     //MARK: - EXTENSION
     extension LoginViewController {
     //Metodo para "escuchar" variable de estado del viewModel
     private func setObservers() {
     viewModel.loginViewState = { [weak self] status in
     switch status {
     
     case .loading(let isLoading):
     self?.loadingView.isHidden = !isLoading
     
     case .loaded:
     self?.loadingView.isHidden = true
     self?.navigateToHome()
     
     case .showErrorEmail(let error):
     self?.errorEmail.text = error
     self?.errorEmail.isHidden = (error == nil || error?.isEmpty == true)
     
     case .showErrorPassword(let error):
     self?.errorPassword.text = error
     self?.errorPassword.isHidden = (error == nil || error?.isEmpty == true)
     case .errorNetwork(let errorMessage):
     self?.loadingView.isHidden = true
     self?.showAlert(message: errorMessage)
     }
     }
     }
     //MARK: Navigate
     private func navigateToHome() {
     let nextVC = HeroesTableViewController()
     navigationController?.setViewControllers([nextVC], animated: true)
     }
     
     //MARK: Alert
     private func showAlert(message: String) {
     let alertController = UIAlertController(title: "ERROR NETWORK", message: message, preferredStyle: .alert)
     let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
     alertController.addAction(okAction)
     present(alertController, animated: true, completion: nil)
     }
     }
     */

