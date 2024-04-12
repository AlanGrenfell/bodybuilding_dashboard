//
//  DailyStepCardView.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 21/05/23.
//

import SwiftUI
import Charts

struct DailyMacroView: View {
    let macroVals: [Int]
    let kcal: Int
    let namesAndColors: [(String, Color)]
    let formatter: (Double) -> String
    
    @ObservedObject var healthKitManager: HealthKitManager
    
    init( healthKitManager: HealthKitManager ) {
        
        self.healthKitManager = healthKitManager
//        self.macroVals  = [435, 213, 43]
//        self.kcal = 2430
        self.namesAndColors = [("carb", .blue),("protein", .orange),("fat", .green)]
        self.formatter = {value in String(format: "%.0f", value)}
        self.macroVals  = [healthKitManager.carbsToday, healthKitManager.proteinToday, healthKitManager.fatToday]
//        self.macroNames = ["carb","protein","fat"]
        self.kcal = healthKitManager.caloriesToday
    }
    
    var body: some View {
        VStack{
            Text ("Macros").font(.title3).fontWeight(.semibold)
        Chart{
            ForEach(Array(zip(self.macroVals, self.namesAndColors)), id: \.0) { item in
                SectorMark(angle: .value("g", item.0), innerRadius: .ratio(0.6),
                           angularInset: 8).foregroundStyle(item.1.1 ).foregroundStyle(by: .value("Macro", item.1.0))
                    .annotation(position: .overlay, alignment: .center) {
                        Text ("\(item.0)").font(.headline).foregroundStyle(.white)
                    }
            }
        }.frame(height: 250).chartLegend(.hidden).chartBackground{ proxy in
            VStack{
                Text ("\(self.kcal)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("kcal")
            }
        }
            PieChartRows(colors: self.namesAndColors.enumerated().map {$1.1}, names: self.namesAndColors.enumerated().map {$1.0}, values: self.macroVals.map { self.formatter(Double($0)) }, percents: self.macroVals.map { String(format: "", $0 * 100 / self.macroVals.reduce(0, +)) })
        }
    }
    
    struct DailyMacroView_Previews: PreviewProvider {
        static var previews: some View {
            DailyMacroView( healthKitManager: HealthKitManager() )
        }
    }
    
}
