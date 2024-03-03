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
    @IBOutlet weak var loginActivityIndication: UIActivityIndicatorView!
    
    
    
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
            switch state {
            case.success:
                self.loginActivityIndication.stopAnimating()
                // Navegamos a Heroes Controller
                DispatchQueue.main.async {
                    // Si el login es con exito, navegamos a la pantalal de Heroes
                    let heroes = HeroesViewController()
                    self.navigationController?.pushViewController(heroes, animated: true)
                }
            case .loading:
                self.loginActivityIndication.startAnimating()
            case .failed:
                self.loginActivityIndication.stopAnimating()
                
            }
        }
    }
    @IBAction func buttonLogin(_ sender: Any) {
        viewModel.loginWith(email: emailTextFiled.text ?? "pabloperagon@gmail.com", password: passwordTextField.text ?? "123456")
    }
}
