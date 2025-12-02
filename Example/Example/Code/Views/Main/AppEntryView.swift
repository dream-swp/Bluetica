//
//  AppMainView.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import SwiftUI

struct AppEntryView: View {
    var body: some View {
        AppTabView.mainBarView
    }
}

#Preview {
    AppEntryView().environmentObject(AppStore())
}
