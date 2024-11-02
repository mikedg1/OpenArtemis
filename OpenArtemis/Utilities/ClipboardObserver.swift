//
//  ClipboardObserver.swift
//  OpenArtemis
//
//  Created by Michael DiGovanni on 11/2/24.
//

import SwiftUI
import Combine

class ClipboardObserver: ObservableObject {
    @Published var clipboardContent: String? = UIPasteboard.general.string

    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIPasteboard.changedNotification)
            .sink { [weak self] _ in
                self?.clipboardContent = UIPasteboard.general.string
            }
    }
}
