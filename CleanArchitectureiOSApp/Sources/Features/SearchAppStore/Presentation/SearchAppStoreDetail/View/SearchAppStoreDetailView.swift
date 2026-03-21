//
//  SearchAppStoreView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

struct SearchAppStoreDetailView: View {
    @StateObject private var viewModel: SearchAppStoreDetailViewModel
    
    private let onBack: () -> Void

    init(
        viewModel: SearchAppStoreDetailViewModel,
        onBack: @escaping () -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("불러오는 중...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Text(errorMessage)
                        .foregroundColor(.red)

                    Button("다시 시도") {
                        viewModel.fetchDetail()
                    }
                }
                .padding()
            } else if let item = viewModel.searchAppStoreDetailEntity {
                VStack(alignment: .leading, spacing: 16) {
                    if let urlString = item.artworkUrl100,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, minHeight: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(radius: 4)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .padding(.bottom, 8)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.trackName)
                            .font(.title)
                            .fontWeight(.bold)

                        Text(item.artistName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    if let rating = item.averageUserRating {
                        Text("평점: \(rating, specifier: "%.1f")점")
                            .font(.subheadline)
                    }

                    if !item.genres.isEmpty {
                        Text("장르: \(item.genres.joined(separator: ", "))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }

                    if let description = item.description, !description.isEmpty {
                        Text(description)
                            .font(.body)
                            .padding(.top, 8)
                    }

                    Button("뒤로 가기") {
                        onBack()
                    }
                    .font(.body)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding(.top, 16)
                }
                .padding()
            } else {
                Text("데이터가 없습니다.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle("앱 상세")
        .navigationBarTitleDisplayMode(.inline)
    }
}
