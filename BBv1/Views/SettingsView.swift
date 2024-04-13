//
//  ActivityView.swift
//  HealthKitTester
//
//

import SwiftUI

struct SettingsView: View {
    
    //  @ObservedObject var healthKitManager: HealthKitManager
    let kcal_goal = Defaults.getKcalGoal().kcal_goal
    
    var body: some View {
        Text(String(kcal_goal))
        

    }
    
    
    struct WeeklyView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
}
