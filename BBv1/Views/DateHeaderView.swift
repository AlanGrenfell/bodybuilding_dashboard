//
//  DailyStepCardView.swift
//  HealthKitTester
//
//

import SwiftUI

struct DateHeaderView: View {
    
    @State private var date = Date.now

    var body: some View {
        VStack(alignment: .center) {
            DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
            }.frame(width: 100, alignment: .center)
        }
    }
    
    
    struct DateHeaderCardView_Previews: PreviewProvider {
        static var previews: some View {
            DateHeaderView()
        }
    }
}
