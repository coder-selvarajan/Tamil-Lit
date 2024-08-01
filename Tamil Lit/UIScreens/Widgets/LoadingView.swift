//
//  LoadingView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 08/07/24.
//

import SwiftUI

enum LoadingStatus {
    case idle, loading, success, failure
}

private struct ShowLoadingKey: EnvironmentKey {
    static let defaultValue: (LoadingStatus) -> Void = { _ in }
}

extension EnvironmentValues {
    var showLoading: (LoadingStatus) -> Void {
        get { self[ShowLoadingKey.self] }
        set { self[ShowLoadingKey.self] = newValue }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Loading...")
                .padding(25)
        }
        .background(Color("TextColorWhite"))
        .cornerRadius(size10)
        .shadow(radius: 5)
    }
}

#Preview {
    LoadingView()
}
