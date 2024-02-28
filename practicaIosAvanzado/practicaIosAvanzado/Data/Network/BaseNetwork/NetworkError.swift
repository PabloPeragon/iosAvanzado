//
//  NetWorkError.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 28/2/24.
//

import Foundation


enum NetworkError: Error {
    case malformedURL
    case dataFormating
    case orther
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}
