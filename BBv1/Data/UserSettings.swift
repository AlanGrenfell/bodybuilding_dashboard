import Foundation


struct Defaults {
    
    static let (nameKey, addressKey) = ("name", "address")
    static let (kcalKey) = ("kcal_goal")


    static let userSessionKey = "com.save.usersession"
    private static let userDefault = UserDefaults.standard
    
    struct UserDetails {
        let kcal_goal: Int

        init(_ json: [String: Int]) {
            self.kcal_goal = json[kcalKey] ?? 2500

        }
    }
    
    static func save(_ kcal_goal: Int){

        userDefault.set([kcalKey: kcal_goal],
                        forKey: userSessionKey)
    }
    
    static func getKcalGoal()-> UserDetails {
        return UserDetails((userDefault.value(forKey: userSessionKey) as? [String: Int]) ?? [:])
    }
    
    static func clearUserData(){
        userDefault.removeObject(forKey: userSessionKey)
    }
}
