//
//  Authentication.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 3/28/23.
//

import Foundation
import FirebaseAuth

var provider = OAuthProvider(providerID: "github.com")

func doAuthenticate() -> String? {
    var errorString: String? = nil
    provider.getCredentialWith(nil) { credential, error in
        if error != nil {
            errorString = "Error retrieving credential"
        }
        if credential != nil {
            Auth.auth().signIn(with: credential!) { _, error in
                if error != nil {
                    errorString = "Error authenticating"
                }
            }
        }
    }
    return errorString
}

func doSignOut() -> String? {
    let firebaseAuth = Auth.auth()
    do {
        try firebaseAuth.signOut()
        return nil
    } catch _ as NSError {
        return "Error attempting to sign out."
    }
}
