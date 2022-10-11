//
//  LoginPage.swift
//  ezyList
//
//  Created by Quantum on 17/8/2565 BE.
//

import SwiftUI

struct LoginPage: View {
    // MARK: - properties
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    
    // MARK: - FaceID Properties
    
    @State var useFaceID: Bool = false
    // MARK: - body
    
    var body: some View {
        VStack {
            VStack {
                Text("ezyList")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.orange)
                    .frame(alignment: .center)

                Text("Login Now")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.mint)
                    .frame(alignment: .center)
            }
            .padding(.top, 80)
            Spacer()
            // MARK: - Textfields
            TextField("Email", text: $loginModel.email)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.email == "" ? Color.black.opacity(0.05) : Color.mint.opacity(0.5)
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 40)
            
            SecureField("Password", text: $loginModel.password)
                .padding()
                
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.password == "" ? Color.black.opacity(0.05) : Color.mint.opacity(0.5)                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            // MARK: - User Prompt to ask to store Login using FaceID on next time
            if loginModel.getBioMetricStatus(){
                Group{
                    if loginModel.useFaceID{
                        Button(action: {
                            // MARK: - Do FaceID Action
                            Task {
                                do{
                                    try await loginModel.authenticateUser()
                                } catch{
                                    loginModel.errorMsg = error.localizedDescription
                                    loginModel.showError.toggle()
                                }
                            }
                            
                        }, label: {
                            VStack{
                                Label{
                                    Text("Use FaceID to Login into previous account")
                                } icon: {
                                    Image(systemName: "faceid")
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                Text("Note: You can turn of it in settings!")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }//:VSTACK
                        })
                    } else {
                        Toggle(isOn: $useFaceID) {
                            Text("Use FaceID to Login")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
            }

            
            Button(action: {
                // MARK: - Action
                
                Task {
                    do{
                        try await loginModel.loginUser(useFaceID: useFaceID)
                    } catch{
                        loginModel.errorMsg = error.localizedDescription
                        loginModel.showError.toggle()
                    }
                }
            }, label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.mint)
                    }
                    .frame(maxWidth: .infinity)
                
            })
            .padding(.vertical, 35)
            .disabled(loginModel.email == "" || loginModel.password == "")
            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1 )
            
            NavigationLink{
                // MARK: - Going Home without Login
                Home()
            } label: {
                Text("Skip Now")
                    .foregroundColor(.gray)
            }
            
        }//:VSTACK
        .padding()
        .alert(loginModel.errorMsg,isPresented: $loginModel.showError){
            
        }
    }
}
// MARK: - preview
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            
    }
}
