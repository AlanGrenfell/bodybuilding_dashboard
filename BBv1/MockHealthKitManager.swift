import Foundation

class MockHealthKitManager: HealthKitManager {
    
    override func requestAuthorization () {print("not today!!")}
    
    override var stepCountToday:Int {
            get {
                return super.stepCountToday
            }
            set {
                super.stepCountToday = 10123
            }
        }
    
    override var carbsToday:Int {
            get {
                return super.carbsToday
            }
            set {
                super.carbsToday = 457
            }
        }
    override var caloriesToday:Int {
            get {
                return super.caloriesToday
            }
            set {
                super.caloriesToday = 2657
            }
        }
    override var proteinToday:Int {
            get {
                return super.proteinToday
            }
            set {
                super.proteinToday = 231
            }
        }

    override var fatToday:Int {
            get {
                return super.fatToday
            }
            set {
                super.fatToday = 45
            }
        }

    override var bodyWeight:Double {
            get {
                return super.bodyWeight
            }
            set {
                super.bodyWeight = 86.6
            }
        }


//    override init() {
//        super.init()
//
//        // steps
//        self.stepCountToday = 10102
//        
//        // macros
//        self.caloriesToday = 2567
//        self.carbsToday = 456
//        self.proteinToday = 234
//        self.fatToday = 50
//        
//        
//        self.sleepEfficiencyToday = 88
//        // body weight
//        self.bodyWeight = 86.6
//        
//    }
}
