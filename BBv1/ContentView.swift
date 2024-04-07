//
//  ContentView.swift
//  BBv1
//
//  Created by Alan Grenfell on 29/03/2024.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        @ObservedObject var healthKitManager: HealthKitManager
//
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

//
//  ContentView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 18/05/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
  @Environment(\.scenePhase) var scenePhase

  @ObservedObject var healthKitManager: HealthKitManager
  
  var body: some View {
      ZStack{
          DateHeaderView()
          Spacer()
          TabView {
              ActivityView(
                healthKitManager: healthKitManager
              )
              .onAppear {
                  healthKitManager.requestAuthorization()
              }
              .tabItem {
                  Label("today", systemImage: "checkmark.circle")
              }
              WeeklyView(healthKitManager: healthKitManager).onAppear {
                  healthKitManager.requestAuthorization()
              }
              .tabItem {
                  Label("Weekly trends", systemImage: "chart.line.uptrend.xyaxis")
              }
          }
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(healthKitManager: MockHealthKitManager())
  }
}

