//
//  HomeView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import SwiftUI

struct HomeView: View {
    let onSearchRequested: (String) -> Void

    @State private var keyword: String = ""

    private var isSearchEnabled: Bool {
        !keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)

            VStack(spacing: 12) {
                TextField("검색어를 입력해 주세요", text: $keyword)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 16)
                    .frame(height: 52)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Button {
                    onSearchRequested(keyword.trimmingCharacters(in: .whitespacesAndNewlines))
                } label: {
                    Text("SearchAppStore")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(isSearchEnabled ? Color.blue : Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(!isSearchEnabled)
            }
            .padding(.horizontal, 24)
        }
        .padding()
        .navigationTitle("")
    }
}

