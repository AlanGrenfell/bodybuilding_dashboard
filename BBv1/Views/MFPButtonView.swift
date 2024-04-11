//
//  MFPButtonView.swift
//  BBv1
//
//  Created by Alan Grenfell on 07/04/2024.
//

import Foundation



//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI
import Charts

struct MFPButtonView: View {
    
    
    @ObservedObject var healthKitManager: HealthKitManager
    
    init( healthKitManager: HealthKitManager ) {
        
        self.healthKitManager = healthKitManager
        
    }
    
    func launchMFPApp() {
        guard let url = URL(string: "https://www.myfitnesspal.com/") else {
            preconditionFailure("There was something wrong with our url, this shouldn't happen")
        }
        if  UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Something went wrong. We might not have the necessary app or the right url.")
        }
    }
    
    
    var body: some View {
        Button("test", action: launchMFPApp)
    }
    
    struct MFPButtonView_Previews: PreviewProvider {
        static var previews: some View {
            MFPButtonView( healthKitManager: HealthKitManager() )
        }
    }
    
}

