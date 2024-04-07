//
//  ActivityView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 19/05/23.
//

import SwiftUI

struct WeeklyView: View {

  @ObservedObject var healthKitManager: HealthKitManager
  
  var body: some View {
    VStack {
      
      ScrollView {
        VStack {
          // MARK: DAILY STEP COUNTER

          WeeklyStepCardView( healthKitManager: healthKitManager)
            .onAppear {
            }
            
        Spacer()
            WeeklyMacrosView( healthKitManager: healthKitManager)
            
        
        }
      }
    }.padding(.top, 16)
  }
}

struct WeeklyView_Previews: PreviewProvider {
  static var previews: some View {
    WeeklyView(
      healthKitManager: HealthKitManager()
    )
  }
}
