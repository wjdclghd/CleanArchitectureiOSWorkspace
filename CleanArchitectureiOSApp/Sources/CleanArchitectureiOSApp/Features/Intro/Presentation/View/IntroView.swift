//
//  IntroView.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/11/26.
//

import SwiftUI

struct IntroView: View {
    let onNext: () -> Void
    
    @State private var didStartTransition = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Intro")
                .font(.largeTitle)
            
            Text("잠시 후 홈 화면으로 이동합니다.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 24)
            
            ProgressView()
                .padding(.top, 8)
            
//            Button("Login") {
//                onNext()
//            }
//            .font(.headline)
//            .foregroundStyle(.white)
//            .frame(maxWidth: .infinity)
//            .frame(height: 52)
//            .background(Color.blue)
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//            .padding(.horizontal, 24)
        }
        .padding()
        .task {
            guard !didStartTransition else { return }
            didStartTransition = true

            if #available(iOS 16.0, *) {
                try? await Task.sleep(for: .seconds(1.5))
            } else {
                try? await Task.sleep(nanoseconds: 1_500_000_000)
            }
            
            onNext()
        }
    }
}
