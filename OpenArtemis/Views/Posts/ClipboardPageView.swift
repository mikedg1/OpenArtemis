//
//  ClipboardPageView.swift
//  OpenArtemis
//
//  Created by Mike DiGovanni on 11/2/24.
//
import SwiftUI

struct ClipboardPageView: View {
    @StateObject private var clipboardObserver = ClipboardObserver()
//    @Default(.textSizePreference) var textSizePreference

    var body: some View {
        VStack {
             Text("Clipboard Content:")
                 .font(.headline)

             if let clipboardContent = clipboardObserver.clipboardContent {
                 Text(clipboardContent)
                     .padding()
                     .border(Color.gray, width: 1)
                     .padding()
             } else {
                 Text("Clipboard is empty.")
                     .padding()
             }
//            PostPageView(post: <#T##Post#>, appTheme: <#T##AppThemeSettings#>, textSizePreference: textSizePreference)
         }
         .padding()
    }
    
    // TODO: copied from nav injector
//    private func handlePostOrComment(url: URL, pathComponents: [String]) {
//        GlobalLoadingManager.shared.setLoading(toState: true)
//        
//        RedditScraper.scrapePostFromURL(url: url.absoluteString, trackingParamRemover: nil) { result in
//            DispatchQueue.main.async {
//                handleRedditPostScrapeResult(result, originalURL: url.absoluteString)
//            }
//        }
//    }
    

}
