//
//  SettingsView.swift
//  OpenArtemis
//
//  Created by daniel on 02/12/23.
//

import SwiftUI
import Defaults
import VisionKit

struct SettingsView: View {
    let textSizePreference: TextSizePreference

    @Default(.accentColor) var accentColor
    @Default(.appTheme) var appTheme
    
    @Default(.redirectToPrivateSites) var redirectToPrivateSites
    @Default(.readerMode) var readerMode
    @Default(.removeTrackingParams) var removeTrackingParams
    @Default(.over18) var over18
    @Default(.swipeAnywhere) var swipeAnywhere
    @Default(.hideReadPosts) var hideReadPosts
    @Default(.markReadOnScroll) var markReadOnScroll
    
    @Default(.showJumpToNextCommentButton) var showJumpToNextCommentButton
    
    @Default(.doLiveText) var doLiveText
    
    @Default(.defaultPostPageSorting) var defaultPostPageSorting
    @Default(.defaultSubSorting) var defaultSubSorting
    @Default(.defaultLaunchFeed) var defaultLaunchFeed
    
    @Default(.useAntiFingerprinting) var useAntiFingerprinting

    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [ SortDescriptor(\.name) ]) var localFavorites: FetchedResults<LocalSubreddit>
    @FetchRequest(sortDescriptors: []) var readPosts: FetchedResults<ReadPost>
    
    @State var currentAppIcon: String = "AppIcon"
    @State private var selectedLightModeBackground: Color = .white
    @State private var selectedDarkModeBackground: Color = .black
    
    @State var showingImportDalog: Bool = false
    @State var showingURLImportSheet: Bool = false
    
    @State var exportedURL: String? = nil
    @State var presentingFileMover: Bool = false
    @State var doImport: Bool = false
    
    @State var showToast: Bool = false
    @State var toastTitle: String = "Success!"
    @State var toastIcon: String = "checkmark.circle.fill"
    @State private var imageAnalyzerSupport: Bool = true
    
    var body: some View {
        ThemedList(appTheme: appTheme, textSizePreference: textSizePreference) {
            Section("About") {
                Link("Contribute on GitHub", destination: URL(string: "https://github.com/ejbills/OpenArtemis")!)
                Link("Join the Discord Community", destination: URL(string: "https://discord.com/invite/lo-cafe")!)
                
                Text("OpenArtemis is an open-source project, and welcomes contributions from the community. You can use the GitHub link to report bugs, request new features, or view the source code. Join the Discord channel to discuss the app with other users and developers.")
                    .font(textSizePreference.caption)
                    .foregroundColor(.secondary)
                
                Link("Show support with a coffee", destination: URL(string: "https://www.buymeacoffee.com/keplercafe")!)
                Text("Consider supporting with a donation if you enjoy using OpenArtemis. Note that donating does not unlock any additional features; OpenArtemis is committed to remaining free forever.")
                    .font(textSizePreference.caption)
                    .foregroundColor(.secondary)
            }

            Section("General") {
                Group {
                    Toggle("Swipe anywhere to go back", isOn: $swipeAnywhere)
                    Text("Note: This option will disable swipe gestures on posts and comments.")
                        .font(textSizePreference.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                
                VStack{
                    Toggle("Live Text Analyzer", isOn: $doLiveText)
                        .disabled(!imageAnalyzerSupport)
                        .onAppear{
                            imageAnalyzerSupport = ImageAnalyzer.isSupported
                            if !ImageAnalyzer.isSupported {
                                doLiveText = false
                            }
                        }
                    
                    if !imageAnalyzerSupport{
                        HStack{
                            Text("Your iPhone does not support Live Text :(")
                                .opacity(0.5)
                            Spacer()
                        }
                    }
                }
                
                Toggle("Auto-enable reader mode in in-app browser", isOn: $readerMode)
                
                if isPhone {
                    Picker("Default Launch Feed", selection: $defaultLaunchFeed) {
                        Text("Home").tag("home")
                        Text("Popular").tag("popular")
                        Text("All").tag("all")
                        Text("Favorites Drawer (default)").tag("favList")
                        
                        let localMultis = SubredditUtils.shared.localMultis(managedObjectContext: managedObjectContext)
                        if !localMultis.isEmpty {
                            Section("Multis") {
                                ForEach(localMultis) { multi in
                                    if let multiName = multi.multiName { Text(multiName.capitalized).tag(multiName) }
                                }
                            }
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
            }
            
            Section("Privacy") {
                Group {
                    Toggle("Use anti-fingerprinting", isOn: $useAntiFingerprinting)
                    Text("Note: This option currently only changes the user agent, so it will not be effective for privacy.")
                        .font(textSizePreference.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }
            
            Section("Appearance") {
                Picker("Preferred Theme", selection: Binding(get: {
                    appTheme.preferredThemeMode
                }, set: { val, _ in
                    appTheme.preferredThemeMode = val
                })){
                    Text("Automatic").tag(PreferredThemeMode.automatic)
                    Text("Light").tag(PreferredThemeMode.light)
                    Text("Dark").tag(PreferredThemeMode.dark)
                }
                ColorPicker("Accent Color", selection: $accentColor)
                ColorPicker("Light Mode Background Color", selection: $selectedLightModeBackground)
                    .onChange(of: selectedLightModeBackground) { _, newColor in
                        appTheme.lightBackground = newColor
                    }
                ColorPicker("Dark Mode Background Color", selection: $selectedDarkModeBackground)
                    .onChange(of: selectedDarkModeBackground) { _, newColor in
                        appTheme.darkBackground = newColor
                    }
                Toggle("Compact mode", isOn: $appTheme.compactMode)
                Toggle("Thin divider between posts", isOn: $appTheme.thinDivider)
                Toggle("Show info tags with background", isOn: $appTheme.tagBackground)
                Toggle("Show author tag on posts in feed", isOn: $appTheme.showAuthor)
                Toggle("Highlight subreddit with accent color", isOn: $appTheme.highlightSubreddit)
                Toggle("Highlight author with accent color", isOn: $appTheme.highlightAuthor)
                
                NavigationLink(destination: TextSizeAdjustmentView(appTheme: appTheme)) {
                    Text("Adjust Font Size")
                }
                
                NavigationLink(destination: CommentThemeView(appTheme: appTheme, textSizePreference: textSizePreference), label: {
                    Text("Comment Indentation Theme")
                })
                
                NavigationLink(destination: ChangeAppIconView(appTheme: appTheme, textSizePreference: textSizePreference), label: {
                    HStack{
                        SafeImage(uiImage: UIImage(named: "AppIcon"))
                            .resizable()
                            .frame(width: 24, height: 24)
                            .mask(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                        Text("App Icon")
                    }
                })
            }
            
            Section("Posts"){
                Button(action: {
                    PostUtils.shared.removeAllReadPosts(context: managedObjectContext)
                    MiscUtils.showAlert(message: "Read posts cleared.")
                }, label: {
                    Label("Clear Read Posts", systemImage: "xmark.circle.fill")
                        .foregroundColor(.red)
                })
                Toggle("Hide Read Posts", isOn: $hideReadPosts)
                Toggle("Mark posts read on scroll", isOn: $markReadOnScroll)
            }
            
            Section("Comments"){
                Toggle("Jump to Next Comment Button", isOn: $showJumpToNextCommentButton)
                Group {
                    let postPageSorting = PostUtils.shared.buildSortingMenu(selectedOption: defaultPostPageSorting, action: { option in
                        withAnimation { defaultPostPageSorting = option }
                    })
                    
                    HStack {
                        Text("Default Comment Sorting")
                        Spacer()
                        postPageSorting.contentShape(Rectangle())
                    }
                }
            }
            
            Section("Subreddits"){
                Picker("Are you over 18 (Allow NSFW content)?", selection: $over18) {
                    Text("No").tag(false)
                    Text("Yes").tag(true)
                }
                
                Group {
                    let subSorting = SubredditUtils.shared.buildSortingMenu(selectedOption: defaultSubSorting, action: { option in
                        withAnimation { defaultSubSorting = option }
                    })
                    
                    HStack {
                        Text("Default Feed Sorting")
                        Spacer()
                        subSorting.contentShape(Rectangle())
                    }
                }
                
                Button{
                    exportedURL = SubredditIOManager().exportSubs(fileName: "artemis_subs.json", subreddits: localFavorites.compactMap { $0.name })
                    presentingFileMover = exportedURL != nil
                } label: {
                    Label("Export Subreddits", systemImage: "arrowshape.turn.up.left")
                }
                Button{
                    showingImportDalog.toggle()
                } label: {
                    Label("Import Subreddits", systemImage: "arrowshape.turn.up.right")
                }
                .confirmationDialog("What do you want to Import?", isPresented: $showingImportDalog, titleVisibility: .automatic, actions: {
                    Button{
                        showingURLImportSheet.toggle()
                    } label: {
                        Label("Import Subreddits From URL", systemImage: "link")
                    }
                    Button {
                        doImport.toggle()
                    } label: {
                        Label("Import Subreddits From File", systemImage: "doc")
                    }
                })
                .sheet(isPresented: $showingURLImportSheet, content: {
                    ImportURLSheet(showingThisSheet: $showingURLImportSheet, appTheme: appTheme, textSizePreference: textSizePreference)
                    
                })
                .fileMover(isPresented: $presentingFileMover, file: URL(string: exportedURL ?? ""), onCompletion: { _ in })
                .fileImporter(isPresented: $doImport, allowedContentTypes: [.json], allowsMultipleSelection: false, onCompletion: { result in
                    switch result {
                    case .success(let file):
                        let success = SubredditIOManager().importSubreddits(jsonFilePath: file[0])
                        if success {
                            showToast.toggle()
                        } else {
                            toastTitle = "There was an Error importing"
                            toastIcon = "xmark.circle.fill"
                            showToast.toggle()
                        }
                    case .failure(_):
                        toastTitle = "There was an Error importing"
                        toastIcon = "xmark.circle.fill"
                        showToast.toggle()
                    }
                    
                })
            }
        }
        .preferredColorScheme(appTheme.preferredThemeMode.id == 0 ? nil : appTheme.preferredThemeMode.id == 1 ? .light : .dark)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            currentAppIcon = AppIconManager().getCurrentIconName()
            selectedLightModeBackground = appTheme.lightBackground
            selectedDarkModeBackground = appTheme.darkBackground
        }
        .toast(isPresented: $showToast, style: .popup, title: toastTitle,systemIcon: toastIcon, speed: 1.5, tapToDismiss: false, onAppear: {})
    }
}



