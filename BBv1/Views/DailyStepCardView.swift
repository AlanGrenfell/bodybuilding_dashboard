//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI

struct DailyStepCardView: View {
    
    
    @ObservedObject var healthKitManager: HealthKitManager
    
    
    init( healthKitManager: HealthKitManager ) {
        
        self.healthKitManager = healthKitManager
        
    }
    
    var body: some View {
        VStack {
            // MARK: STEPS TODAY
            
            Text("Steps today").font(.title3).fontWeight(.semibold)
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(healthKitManager.stepCountToday)").font(.system(size: 72, weight: .bold)).padding(.leading, 20)
                    Image(systemName: "shoeprints.fill").padding(.bottom, 14).padding(.leading, -2)
                }.padding(.bottom, -16)
                
            }
            
        }
    }
    
    struct DailyStepCardView_Previews: PreviewProvider {
        static var previews: some View {
            DailyStepCardView( healthKitManager: HealthKitManager() )
        }
    }
}
