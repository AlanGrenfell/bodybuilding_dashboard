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
    
    var formatter : NumberFormatter
    
    init( healthKitManager: HealthKitManager ) {
        
        self.healthKitManager = healthKitManager
        self.formatter = NumberFormatter()
        self.formatter.numberStyle = .decimal
        self.formatter.minimumFractionDigits = 2
        self.formatter.maximumFractionDigits = 2
    }
    
    var body: some View {
        VStack {
            // MARK: STEPS TODAY
            
            Text("Time asleep").font(.title3).fontWeight(.semibold)
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(self.formatter.string(from: healthKitManager.timeAsleepToday as NSNumber)!).font(.system(size: 72, weight: .bold)).padding(.leading, 20)
                    Text(" hours")
//                    Image(systemName: "bed.double.circle").padding(.bottom, 14).padding(.leading, -2)
                }.padding(.bottom, 0)
                
            }
            
        }
    }
    
    struct DailySleepCardView_Previews: PreviewProvider {
        static var previews: some View {
            DailySleepCardView( healthKitManager: HealthKitManager() )
        }
    }
}
