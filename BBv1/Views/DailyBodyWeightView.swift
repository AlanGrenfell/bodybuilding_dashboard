//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI

struct DailyBodyWeightView: View {
    
    @ObservedObject var healthKitManager: HealthKitManager
    var formatter : NumberFormatter
    
    init( healthKitManager: HealthKitManager ) {
        
        self.healthKitManager = healthKitManager
        self.formatter = NumberFormatter()
        self.formatter.numberStyle = .decimal
        self.formatter.minimumFractionDigits = 1
        self.formatter.maximumFractionDigits = 1
    }
    
    var body: some View {
        VStack {
            // MARK: bw TODAY
            
            
            Text("Weight").font(.title3).fontWeight(.semibold)
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(self.formatter.string(from: healthKitManager.bodyWeight as NSNumber)!).font(.system(size: 72, weight: .bold)).padding(.leading, 20)
//                    Image(systemName: "scalemass").padding(.bottom, 14).padding(.leading, -2)
                }.padding(.bottom, -16)
                
            }
            
        }
    }
    
    struct DailyBodyWeightView_Previews: PreviewProvider {
        static var previews: some View {
            DailyBodyWeightView( healthKitManager: HealthKitManager() )
        }
    }
}
