//
//  HealthKitManager.swift
//  HealthKitTester
//
//  Created by Kevin Bryan on 18/05/23.
//

import Foundation
import HealthKit
import WidgetKit

class HealthKitManager: ObservableObject {
  var healthStore = HKHealthStore()
// steps
  var stepCountToday: Int = 0
  var stepCountYesterday: Int = 0

  var thisWeekSteps: [Int: Int] = [1: 0,
                                   2: 0,
                                   3: 0,
                                   4: 0,
                                   5: 0,
                                   6: 0,
                                   7: 0]
    var thisWeekStepsAvg: Int = 0
 // macros
    var caloriesToday: Int = 0
    var carbsToday: Int = 0
    var proteinToday: Int = 0
    var fatToday: Int = 0
    
    var thisWeekMacros: [Int: Int] = [1: 0,
                                      2: 0,
                                      3: 0,
                                      4: 0,
                                      5: 0,
                                      6: 0,
                                      7: 0]
    var carbsAvgThisWeek: Int = 0
    var proteinAvgThisWeek: Int = 0
    var fatAvgThisWeek: Int = 0
 // sleep
    var sleepEfficiencyToday: Int = 0
 // body weight
    var bodyWeight: Double = 0

  static let shared = HealthKitManager()

  init() {
    requestAuthorization()
  }

  func requestAuthorization() {
    let toReads = Set([
    // steps
      HKObjectType.quantityType(forIdentifier: .stepCount)!,
    // macros
      HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
      HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!,
      HKObjectType.quantityType(forIdentifier: .dietaryProtein)!,
    // sleep
      HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
      HKObjectType.quantityType(forIdentifier: .bodyMass)!
    ])
    guard HKHealthStore.isHealthDataAvailable() else {
      print("health data not available!")
      return
    }
    healthStore.requestAuthorization(toShare: nil, read: toReads) {
      success, error in
      if success {
        self.fetchAllDatas()
      } else {
        print("\(String(describing: error))")
      }
    }
  }

  func fetchAllDatas() {
//    readStepCountYesterday()
    readStepCountToday()
    readProteinToday()
    readCarbToday()
    readFatToday()
    readCaloriesToday()
    readBodyWeightToday()
    readStepCountThisWeek()
    readMacrosThisWeek()
    thisWeekAvgCarbs()
    thisWeekAvgFat()
    thisWeekAvgProtein()
    
  }

  func readStepCountYesterday() {
    guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
      return
    }

    let calendar = Calendar.current
    let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
    let startDate = calendar.startOfDay(for: yesterday!)
    let endDate = calendar.startOfDay(for: Date())
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

    print("attempting to get step count from \(startDate)")

    let query = HKStatisticsQuery(
      quantityType: stepCountType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum
    ) {
      _, result, error in
      guard let result = result, let sum = result.sumQuantity() else {
        print("failed to read yest step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
        return
      }
      
      let steps = Int(sum.doubleValue(for: HKUnit.count()))
      print("Fetched your steps yesterday: \(steps)")
      self.stepCountYesterday = steps
    }
    healthStore.execute(query)
  }

  func readStepCountToday() {
    guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
      return
    }

    let now = Date()
    let startDate = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(
      withStart: startDate,
      end: now,
      options: .strictStartDate
    )

//    print("attempting to get step count from \(startDate)")

    let query = HKStatisticsQuery(
      quantityType: stepCountType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum
    ) {
      _, result, error in
      guard let result = result, let sum = result.sumQuantity() else {
        print("failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
        return
      }

      let steps = Int(sum.doubleValue(for: HKUnit.count()))
//      print("Fetched your steps today: \(steps)")
      self.stepCountToday = steps
    }
    healthStore.execute(query)
  }
    
    func readBodyWeightToday() {
        guard let bodyWeightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
        return
      }

      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )

      let query = HKStatisticsQuery(
        quantityType: bodyWeightType,
        quantitySamplePredicate: predicate,
        options: .mostRecent
      ) {
        _, result, error in
        guard let result = result,
              let sum = result.mostRecentQuantity() else {
          print("failed to bodyweight: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }
          // round to 2 dp
          print("bodyweight")
          let bodyweight = Double(round(10 * sum.doubleValue(for: HKUnit.gramUnit(with: .kilo))) / 10)
          print(bodyweight)
          self.bodyWeight = bodyweight
      }
      healthStore.execute(query)
    }
    
    func readCarbToday() {
      guard let carbType = HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates) else {
        return
      }

      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )

      let query = HKStatisticsQuery(
        quantityType: carbType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
      ) {
        _, result, error in
        guard let result = result, let sum = result.sumQuantity() else {
          print("failed to read carbs: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }

        let carbs = Int(sum.doubleValue(for: HKUnit.gram()))
  //      print("Fetched your steps today: \(steps)")
        self.carbsToday = carbs
      }
      healthStore.execute(query)
    }
    
    func readFatToday() {
      guard let fatType = HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal) else {
        return
      }

      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )

      let query = HKStatisticsQuery(
        quantityType: fatType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
      ) {
        _, result, error in
        guard let result = result, let sum = result.sumQuantity() else {
          print("failed to read fat: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }

          let fat = Int(sum.doubleValue(for: HKUnit.gram()))
  //      print("Fetched your steps today: \(steps)")
          self.fatToday = fat
      }
      healthStore.execute(query)
    }
    
    func readProteinToday() {
      guard let proteinType = HKQuantityType.quantityType(forIdentifier: .dietaryProtein) else {
        return
      }

      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )

      let query = HKStatisticsQuery(
        quantityType: proteinType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
      ) {
        _, result, error in
        guard let result = result, let sum = result.sumQuantity() else {
          print("failed to read protein: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }
    

          let protein = Int(sum.doubleValue(for: HKUnit.gram()))

          self.proteinToday = protein
      }
      healthStore.execute(query)
    }
    
    func readCaloriesToday() {
        self.caloriesToday = (self.carbsToday * 4) + (self.fatToday * 9) + (self.proteinToday*4)
    }

//  func readCalorieCountToday() {
//    guard let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
//      return
//    }
//    let now = Date()
//    let startDate = Calendar.current.startOfDay(for: now)
//
//    let predicate = HKQuery.predicateForSamples(
//      withStart: startDate,
//      end: now,
//      options: .strictStartDate
//    )
//
//    print("attempting to get calories burned from \(startDate)")
//
//    let query = HKSampleQuery(sampleType: calorieType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, _ in
//      guard let samples = results as? [HKQuantitySample], let firstSample = samples.first else {
//        print("No calorie burn samples found.")
//        return
//      }
//
//      // Retrieve the total calories burned for today
//      let totalCalories = samples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.kilocalorie()) }
//
//      // Process the total calories burned
////      print("Total calories burned today: \(totalCalories) kcal")
//      self.caloriesBurnedToday = Int(totalCalories)
//    }
//
//    healthStore.execute(query)
//  }
    
    func getPredicateForNWeekAgo(weeksAgo: Int = 1) -> NSPredicate {
        let start = getStartAndEndOfWeek(weeksAgo: weeksAgo)[0]
        let end = getStartAndEndOfWeek(weeksAgo: weeksAgo)[1]
            let predicate = HKQuery.predicateForSamples(
              withStart: start,
              end: end,
              options: .strictStartDate
            )
            return predicate
    }
    
    func getStartAndEndOfWeek(weeksAgo: Int) -> [Date] {
        let calendar = Calendar.current
        
        func addOrSubtractDays(toSubtract: Int) -> Date {
            Calendar.current.date(byAdding: .day, value: toSubtract, to: Date())!
        }
        
        let oneWeekAgo = addOrSubtractDays(toSubtract: -7)
        if weeksAgo == 1 {
            let today = calendar.startOfDay(for: Date())
            return [today, oneWeekAgo]
        } else {
            let twoWeeksAgo = addOrSubtractDays(toSubtract: -14)
            return [oneWeekAgo, twoWeeksAgo]
        }
    }
    

  func readStepCountThisWeek() {
    guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
      return
    }
//    let calendar = Calendar.current
//    let today = calendar.startOfDay(for: Date())
//    // Find the start date (Monday) of the current week
//    guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
//      print("Failed to calculate the start date of the week.")
//      return
//    }
//    // Find the end date (Sunday) of the current week
//    guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
//      print("Failed to calculate the end date of the week.")
//      return
//    }
//
//    let predicate = HKQuery.predicateForSamples(
//      withStart: startOfWeek,
//      end: endOfWeek,
//      options: .strictStartDate
//    )
      let startOfWeek = getStartAndEndOfWeek(weeksAgo: 1)[0]
      let endOfWeek = getStartAndEndOfWeek(weeksAgo: 1)[1]

      let predicate = getPredicateForNWeekAgo(weeksAgo: 1)

    let query = HKStatisticsCollectionQuery(
      quantityType: stepCountType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum,
      anchorDate: startOfWeek,
      intervalComponents: DateComponents(day: 1)
    )

    query.initialResultsHandler = { _, result, error in
      guard let result = result else {
        if let error = error {
          print("An error occurred while retrieving weeks step count: \(error.localizedDescription)")
        }
        return
      }

      result.enumerateStatistics(from: startOfWeek, to: endOfWeek) { statistics, _ in
        if let quantity = statistics.sumQuantity() {
          let steps = Int(quantity.doubleValue(for: HKUnit.count()))
          let day = Calendar.current.component(.weekday, from: statistics.startDate)
          self.thisWeekSteps[day] = steps
            
        }
          let sum =  self.thisWeekSteps.reduce(0) { $0 + $1.value }
          self.thisWeekStepsAvg = sum / 7
      }

    }
    healthStore.execute(query)
  }
    
    func readMacrosThisWeek() {
        guard let proteinType = HKQuantityType.quantityType(forIdentifier: .dietaryProtein) else {
            return
        }
        guard let fatType = HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal) else {
            return
        }
        guard let carbsType = HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates) else {
            return
        }
        let macros = [fatType, proteinType, carbsType]
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        // Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return
        }
        // Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return
        }
        
        //    print("Attempting to get stepcount from \(startOfWeek) to \(endOfWeek)")
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfWeek,
            end: endOfWeek,
            options: .strictStartDate
        )
        for macroType in macros{
            let query = HKStatisticsCollectionQuery(
                quantityType: macroType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: startOfWeek,
                intervalComponents: DateComponents(day: 1)
            )
            
            query.initialResultsHandler = { _, result, error in
                guard let result = result else {
                    if let error = error {
                        print("An error occurred while retrieving macros: \(error.localizedDescription)")
                    }
                    return
                }
                
                result.enumerateStatistics(from: startOfWeek, to: endOfWeek) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let macro = Int(quantity.doubleValue(for: HKUnit.gram()))
                        let day = calendar.component(.weekday, from: statistics.startDate)
                        self.thisWeekMacros[day] = macro
                        
                    }
//                    let sum =  self.thisWeekMacros.reduce(0) { $0 + $1.value }
//                    self.thisWeekStepsAvg = sum / 7
                }
                
            }
            healthStore.execute(query)
        }
    }
    func thisWeekAvgCarbs() {
        let sum =  self.thisWeekMacros.reduce(0) { $0 + $1.value }
        self.carbsAvgThisWeek = sum / 7
    }
    func thisWeekAvgFat() {
        let sum =  self.thisWeekMacros.reduce(0) { $0 + $1.value }
        self.fatAvgThisWeek = sum / 7
    }
    func thisWeekAvgProtein() {
        let sum =  self.thisWeekMacros.reduce(0) { $0 + $1.value }
        self.proteinAvgThisWeek = sum / 7
    }
    
    func readSleepAnalysis() {
        
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let startDate = calendar.startOfDay(for: yesterday!)
        let endDate = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        var timeInBed: Double = 0.0
        var timeAsleep: Double = 0.0
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            // the block completion to execute
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 100000, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                if error != nil {
                    // Handle the error in your app gracefully
                    return
                }
                if let result = tmpResult {
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            switch sample.value {
                            case 0:
                                // inBed, write logic here
                                print("inBed")
                                if let sample = item as? HKCategorySample {
                                    
                                    timeInBed = sample.endDate.timeIntervalSince(sample.startDate)
                                }
                            case 1:
                                // asleep, write logic here
                                print("asleep")
                                if let sample = item as? HKCategorySample {
                                    
                                    timeAsleep = sample.endDate.timeIntervalSince(sample.startDate)
                                }
                            default:
                                // awake, write logic here
                                print("awake")
                            }
                            
                        }
                    }
                }
                
                self.sleepEfficiencyToday = Int(timeAsleep / timeInBed)
                self.healthStore.execute(query)
            }
            
        }
    }
            
            
            
        }
        
    

