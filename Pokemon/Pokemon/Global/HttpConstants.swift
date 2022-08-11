//
//  HttpConstants.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation

enum ResponseCode {
     
    /**
     * HTTP Status-Code 200: OK.
    */
    static let httpOK = 200
    
    /**
    * HTTP Status-Code 404: Not Found.
    */
    static let httpNotFound = 404
    

    /**
    * Internet ConnectionError.
    */
    static let internetConnectionError = NSURLErrorNotConnectedToInternet
}


