//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI

struct WeeklyStepCardView: View {
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
            // MARK: STEPS THIS WEEK
            
            Text("Avg steps this week").font(.title3).fontWeight(.semibold)
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(healthKitManager.thisWeekStepsAvg)").font(.system(size: 72, weight: .bold)).padding(.leading, 20)
                    Image(systemName: "shoeprints.fill").padding(.bottom, 14).padding(.leading, -2)
                }.padding(.bottom, -16)
                
            }
            
        }
    }
    
    struct WeeklyStepCardView_Previews: PreviewProvider {
        static var previews: some View {
            WeeklyStepCardView( healthKitManager: HealthKitManager() )
        }
    }
}
