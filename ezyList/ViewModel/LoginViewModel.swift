//
//  LoginViewModel.swift
//  ezyList
//
//  Created by Quantum on 17/8/2565 BE.
//

import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - FaceID Properties
    
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    // MARK: - Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("uid") var uid: String = ""
    @AppStorage("email") var getEmail: String = ""
    
    // MARK: - error
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    // MARK: - Get uid
    func getUid() -> String{
        if let user = Auth.auth().currentUser?.uid {self.uid = user}
        return self.uid
    }
    
    // MARK: - Get Name
    
    func getEmailCurrent() -> String{
        if let email = Auth.auth().currentUser?.email {self.getEmail = email}
        return self.getEmail
    }
//
    
    // MARK: - Firebase Login
    func loginUser(useFaceID: Bool,email: String = "", password: String = "")async throws{
    
        let _ = try await Auth.auth().signIn(withEmail: email != "" ?  email : self.email, password: password != "" ? password : self.password)
        
        DispatchQueue.main.async {
            // Stroing Once
            if useFaceID && self.faceIDEmail == ""{
                
                self.useFaceID = useFaceID
                
                // MARK: - Storing for future face ID Login
                self.faceIDEmail = self.email
                self.faceIDPassword = self.password
            }
            self.logStatus = true
        }
    }
    //Get User
    
    
    // MARK: - FaceID Usage
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    // MARK: - FaceID Login
    
    func authenticateUser()async throws{
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "to Login Into App")
        
        if status{
            try await loginUser(useFaceID: useFaceID, email:  self.faceIDEmail, password: self.faceIDPassword)
        }
    }
}


