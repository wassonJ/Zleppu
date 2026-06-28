import Foundation
import Observation

@Observable
final class AuthState {
    var isLoggedIn = false
    var isGuest = false
    var showLogin = false
    var phoneNumber = ""
    var displayName = MockData.displayName

    func loginAsGuest() {
        isGuest = true
        isLoggedIn = true
        showLogin = false
        displayName = "Guest"
        phoneNumber = "Guest mode · no SMS required"
    }

    func verifyCode(_ code: String) -> Bool {
        guard code.count == 6, code.allSatisfy(\.isNumber) else { return false }
        isGuest = false
        isLoggedIn = true
        showLogin = false
        displayName = MockData.displayName
        return true
    }

    func signOut() {
        isLoggedIn = false
        isGuest = false
        showLogin = false
        phoneNumber = ""
        displayName = MockData.displayName
    }
}

@Observable
final class AppState {
    var showIncomingCall = false
    var showActiveCall = false
    var showMorningSummary = false
    var showApproveAlarm = false
    var selectedRoom: Room = MockData.mainRoom
}
