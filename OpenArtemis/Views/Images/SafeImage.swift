//
//  SafeImage.swift
//  OpenArtemis
//
//  Created by Mike DiGovanni on 11/3/24.
//
import Foundation
import SwiftUI

struct SafeImage: View {
    var uiImage: UIImage?
    private var isResizable: Bool = false

    init(uiImage: UIImage?) {
        self.uiImage = uiImage
    }
    
    var body: some View {
        var image: Image
        
        if let uiImage = self.uiImage {
            image = Image(uiImage: uiImage)
        } else {
            image = Image(systemName: "")
        }
        
        if isResizable {
            image = image.resizable()
        }

        return image
    }
    
    func resizable() -> SafeImage {
        var view = self
        view.isResizable = true
        return view
    }
}
