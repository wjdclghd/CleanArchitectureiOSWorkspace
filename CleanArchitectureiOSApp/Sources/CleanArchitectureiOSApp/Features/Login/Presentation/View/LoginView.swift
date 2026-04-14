//
//  LoginView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import SwiftUI

struct LoginView: View {
    let onLoginSuccess: () -> Void

    @State private var userID: String = ""
    @State private var password: String = ""

    private var isLoginEnabled: Bool {
        !userID.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !password.isEmpty
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            VStack(spacing: 12) {
                Text("Login")
                    .font(.largeTitle)
//                    .fontWeight(.bold)

                Text("아이디와 비밀번호를 입력해 주세요")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 14) {
                TextField("아이디", text: $userID)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.username)
                    .submitLabel(.next)
                    .padding(.horizontal, 16)
                    .frame(height: 52)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                SecureField("비밀번호", text: $password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .submitLabel(.go)
                    .padding(.horizontal, 16)
                    .frame(height: 52)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 24)

            Button {
                onLoginSuccess()
            } label: {
                Text("로그인")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(isLoginEnabled ? Color.blue : Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(!isLoginEnabled)
            .padding(.horizontal, 24)

            Spacer()
        }
        .padding(.vertical, 24)
        .navigationTitle("")
    }
}
