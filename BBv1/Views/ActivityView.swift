//
//  ActivityView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 19/05/23.
//

import SwiftUI

struct ActivityView: View {

  @ObservedObject var healthKitManager: HealthKitManager
  
  var body: some View {
    VStack {
      
      ScrollView {

        VStack {
            DateHeaderView()
            Spacer()
            DailyMacroView(healthKitManager: healthKitManager)
            Spacer()
            DailyStepCardView( healthKitManager: healthKitManager)
            Spacer()
            DailySleepCardView(healthKitManager: healthKitManager)
            Spacer()
            DailyBodyWeightView(healthKitManager: healthKitManager)
        }
      }
    }.padding(.top, 16)
  }
}

struct ActivityView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityView(
      healthKitManager: HealthKitManager()
    )
  }
}
