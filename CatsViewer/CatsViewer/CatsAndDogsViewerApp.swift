//
//  CatsViewerApp.swift
//  CatsViewer
//
//  Created by Никита Боровик on 21.05.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CatsAndDogsViewerApp: App {
    
    //@AppStorage("ShouldShowAllert") var shouldShowAllert = true
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(shouldShowDogs: shouldShowDogs())
            
//                .alert(isPresented: $shouldShowAllert){
//                    Alert(
//                        title: Text("Do you want to send your crash reports?"),
//                        message: Text("Your personal data is safe"),
//                        primaryButton: .default(
//                            Text("Yes"),
//                            action: {
//                                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
//                            }
//                        ),
//                        secondaryButton: .destructive(
//                            Text("No"),
//                            action: {
//                                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
//                            }
//                        )
//
//                    )
//                }
        }
        
    }
    private func shouldShowDogs() -> Bool{
        let plist = Bundle.main.infoDictionary
        guard let appConfig = plist?[Const.CONFIG] as? String
        else {fatalError("No config!")}
        return appConfig == "DOGS"
    }
}

private enum Const{
    static let CONFIG = "App Type"
}
