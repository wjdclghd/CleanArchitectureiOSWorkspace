//
//  MyPage.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/13/26.
//

import SwiftUI

struct MyPageView: View {
    let onOpenSettings: () -> Void
    let onLogout: () -> Void

    var body: some View {
        List {
            Section("계정") {
                HStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.blue)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("마이페이지")
                            .font(.headline)
                        Text("로그인된 사용자")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            Section("메뉴") {
                Button("설정") {
                    onOpenSettings()
                }

                Button(role: .destructive, action: onLogout) {
                    Text("로그아웃")
                }
            }
        }
        .navigationTitle("마이페이지")
    }
}
