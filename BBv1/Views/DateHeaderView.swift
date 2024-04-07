//
//  DailyStepCardView.swift
//  HealthKitTester
//
//

import SwiftUI

struct DateHeaderView: View {
    var timeStamp : String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                Text("\(timeStamp)")
//                    .frame(width: geometry.size.width * 1.4, height: geometry.size.height * 0.33)
//                    .position(x: geometry.size.width / 2.35, y: geometry.size.height * 0.1)
//            }
//        }
            VStack(alignment: .center)
                   {
                                
                                        Text("\(timeStamp)")
                                    .font(.system(size: 30, weight: .light))

                                Spacer() // Push header to top
                            }
                    
    }
    
    struct WeeklyStepCardView_Previews: PreviewProvider {
        static var previews: some View {
            WeeklyStepCardView( healthKitManager: HealthKitManager() )
        }
    }
}
