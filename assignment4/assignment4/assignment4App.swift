//
//  assignment4App.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


@main
struct assignment4App: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RegisterView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

        
