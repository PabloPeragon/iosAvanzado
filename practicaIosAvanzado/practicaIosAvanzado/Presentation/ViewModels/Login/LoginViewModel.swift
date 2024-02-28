//
//  LoginViewModel.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import Foundation

final class LoginViewModel {
    
    //binding con UI
    var loginViewState: ((LoginStatusLoad) -> Void)?
    
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
        //TODO: llamar al caso de uso para hacer la peticion de login y obtener el TOKEN
        //TODO: Esto es para probar la navegación
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.loginViewState?(.loaded)
        }
    }
}
