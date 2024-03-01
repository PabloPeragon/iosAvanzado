//
//  LoginViewModel.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import Foundation


//indica al controller el estado
enum LoginState {
    case loading
    case success
    case failed
}


final class LoginViewModel {
    
    private let apiProvider: ApiProvider
    
    var loginStateChanged: ((LoginState) -> Void)?
    
    init(apiProvider: ApiProvider = ApiProvider()) {
        self.apiProvider = apiProvider
    }
    
    func loginWith(email: String, password: String) {
        self.loginStateChanged?(.loading)
        apiProvider.loginWith(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.loginStateChanged?(.success)
                }
            case .failure(let error):
                self?.loginStateChanged?(.failed)
                debugPrint(error.localizedDescription)
            }
        }
    }
}



/*
import Foundation

final class LoginViewModel {
    
    //binding con UI
    var loginViewState: ((LoginStatusLoad) -> Void)?
    
    private let loginUseCase: LoginUseCaseProtocol
    
    //Init
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }

    
    //metodo Login
    func onLoginButton(email: String?, password: String?) {
        loginViewState?(.loading(true))
        
        //Check email
        guard let email = email, isValid(email: email) else  {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorEmail("Error en el email"))
            return
        }
        
        //Check password
        guard let password = password, isValid(password: password) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorPassword("Error en la password"))
            return
        }
        
        doLoginWith(email: email, password: password)
        
    }
    
    //Check email
    private func isValid(email: String) -> Bool {
        email.isEmpty == false && email.contains("@")
    }
    
    //Check password
    private func isValid(password: String) -> Bool {
        password.isEmpty == false && password.count >= 4
    }
    
    private func doLoginWith(email: String, password: String) {
        loginUseCase.login(user: email, password: password) { [weak self] token in
            //Codigo por success
            DispatchQueue.main.async {
                self?.loginViewState?(.loaded)
            }
        } onError: { [weak self] networError in
            //Codigo por error
            var errorMessage = "Error Desconocido"
            DispatchQueue.main.async {
                switch networError {
                case .malformedURL:
                    errorMessage = "malformedURL"
                case .dataFormating:
                    errorMessage = "dataFormating"
                case .orther:
                    errorMessage = "orther"
                case .noData:
                    errorMessage = "noData"
                case .errorCode(let error):
                    errorMessage = "errorCode \(error?.description ?? "Unknown")"
                case .tokenFormatError:
                    errorMessage = "tokenFormatError"
                case .decoding:
                    errorMessage = "decoding"
                }
                self?.loginViewState?(.errorNetwork(errorMessage))
            }
        }

    }
    
}
*/
