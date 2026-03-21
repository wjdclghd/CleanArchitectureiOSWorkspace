//
//  SearchAppStoreList.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

struct SearchAppStoreListView: View {
    @StateObject private var viewModel: SearchAppStoreListViewModel
    private let onSelectItem: (SearchAppStoreListEntity) -> Void
    
    init(
        viewModel: SearchAppStoreListViewModel,
        onSelectItem: @escaping (SearchAppStoreListEntity) -> Void)
    {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectItem = onSelectItem
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("검색 중...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.searchAppStoreListEntity.isEmpty {
                Text("검색 결과가 없습니다.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.searchAppStoreListEntity) { item in
                    Button {
                        onSelectItem(item)
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            if let urlString = item.artworkUrl100,
                               let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.trackName)
                                    .font(.headline)

                                Text(item.artistName)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                if let rating = item.averageUserRating {
                                    Text("평점: \(rating, specifier: "%.1f")")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("검색 결과")
    }
}
