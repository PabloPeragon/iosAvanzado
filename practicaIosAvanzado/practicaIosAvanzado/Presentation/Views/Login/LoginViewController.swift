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
        setObservers()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(frameKeyboardChanged(notification:)),
                                               name: UIResponder.keyboardDidChangeFrameNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    //MARK: - IBAction
    @IBAction func onLoginButtonTap(_ sender: Any) {
        viewModel.onLoginButton(email: emailTextFiled.text, password: passwordTextField.text)
    }
    
    @objc func frameKeyboardChanged(notification: Notification) {
        debugPrint(notification.userInfo)
        
        let userInfo = notification.userInfo
        let frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let delta = UIScreen.main.bounds.size.height - (frame?.origin.y ?? 0)
        self.btnAceptBotton.constant = defaultBottonConstant + delta
        
    }
    
}

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
            }
        }
    }
    
    private func navigateToHome() {
        let nextVC = HomeTableViewController()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}
