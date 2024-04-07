//
//  BBv1App.swift
//  BBv1
//
//  Created by Alan Grenfell on 29/03/2024.
//

//import SwiftUI
//
//@main
//struct BBv1App: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//
//  HealthKitTesterApp.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 18/05/23.
//

import Foundation
import SwiftUI
import UIKit

@main
struct HealthKitTesterApp: App {
  
  @StateObject var healthKitManager = HealthKitManager.shared

  var body: some Scene {
    WindowGroup {
        ContentView(healthKitManager: healthKitManager)
          .onAppear {
            healthKitManager.requestAuthorization()
            

            // MARK: if you need to reboot the app (delete everything and re-seed)

//            coreDataManager.freshRestart()
          }

      
      }
    }
  }
