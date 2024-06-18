
import Foundation

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dayInWeek = dateFormatter.string(from: self).uppercased()
        switch dayInWeek {
        case "MON":
            return "MON"
        case "TUE":
            return "TUE"
        case "WED":
            return "WED"
        case "THU":
            return "THU"
        case "FRI":
            return "FRI"
        case "SAT":
            return "SAT"
        case "SUN":
            return "SUN"
        default:
            return ""
        }
    }
}
