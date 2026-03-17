//
//  LoginView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import Foundation
import SwiftUI

struct LoginView: View {
    let onLoginSuccess: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
            
            Button("로그인") {
                onLoginSuccess()
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 24)
        }
        .padding()
    }
}
