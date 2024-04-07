//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI

struct DailySleepCardView: View {
    let barWidth = CGFloat(240)
    
    
    @ObservedObject var healthKitManager: HealthKitManager
    
    
    //  @State var stepPercentage: Double = 0.0
    //  @State var progressWidth: CGFloat
    
    init( healthKitManager: HealthKitManager ) {
        
        self.healthKitManager = healthKitManager
        
        //    self.progressWidth = CGFloat(activityViewController.stepPercentage * barWidth)
    }
    
    var body: some View {
        VStack {
            // MARK: STEPS TODAY
            
            Text("Sleep efficiency").font(.title3).fontWeight(.semibold)
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(healthKitManager.sleepEfficiencyToday)").font(.system(size: 72, weight: .bold)).padding(.leading, 20)
                    Image(systemName: "bed.double.circle").padding(.bottom, 14).padding(.leading, -2)
                }.padding(.bottom, -16)
                
            }
            
        }
    }
    
    struct DailySleepCardView_Previews: PreviewProvider {
        static var previews: some View {
            DailySleepCardView( healthKitManager: HealthKitManager() )
        }
    }
}
