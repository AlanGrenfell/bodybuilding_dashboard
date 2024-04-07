//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI

struct WeeklyMacrosView: View {
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
            // MARK: MACROS THIS WEEK
            
            Text("Avg macros this week").font(.title3).fontWeight(.semibold)
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    VStack {
                        Text("Carbs").fontWeight(.medium).foregroundColor(.gray).multilineTextAlignment(.center)
                        Text("\(healthKitManager.carbsAvgThisWeek)").font(.system(size: 72, weight: .bold)).padding(.leading, 20).multilineTextAlignment(.center)
                        }
                    VStack {
                        Text("Protein").fontWeight(.medium).foregroundColor(.gray).multilineTextAlignment(.center)
                        Text("\(healthKitManager.proteinAvgThisWeek)").font(.system(size: 72, weight: .bold)).padding(.leading, 20).multilineTextAlignment(.center)
                        }
                    VStack {
                        Text("Fat").fontWeight(.medium).foregroundColor(.gray).multilineTextAlignment(.center)
                        Text("\(healthKitManager.fatAvgThisWeek)").font(.system(size: 72, weight: .bold)).padding(.leading, 20).multilineTextAlignment(.center)
                        }
                    
                    
                    
                    
                    
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
