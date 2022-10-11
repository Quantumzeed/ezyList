//
//  Profile.swift
//  ezyList
//
//  Created by Quantum on 24/8/2565 BE.
//

import SwiftUI
import Firebase

struct Profile: View {
    // MARK: - Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    // MARK: - FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    
    var body: some View {
        VStack{
            if logStatus{
                Text("Logged In")
                Button("Logout"){
                    try? Auth.auth().signOut()
                    logStatus = false
                }
            }else{
                Text("Came as Guest")
            }
            if useFaceID{
                // MARK: - clearing FaceID
                Button("Disable Face ID"){
                    useFaceID = false
                    faceIDEmail = ""
                    faceIDPassword = ""
                }
            }
        }//:VSTACK
        .navigationViewStyle(.stack)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
