//
//  PlaceholderView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 4/11/26.
//

/*
 각 TabBar 기능들이 구현 및 적용시 삭제 대상
 */
import SwiftUI

struct PlaceholderView: View {
    let title: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "square.dashed")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
//            Text(title)
//                .font(.headline)
//                .foregroundStyle(.secondary)
            Text("준비 중입니다.")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("")
    }
}
