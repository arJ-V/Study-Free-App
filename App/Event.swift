import SwiftUI
//#-learning-task(event)

/*#-code-walkthrough(2.eventType)*/
struct Event: Identifiable, Hashable {
    /*#-code-walkthrough(2.eventType)*/
    /*#-code-walkthrough(2.eventProperties)*/
    var id = UUID()
    var symbol: String = EventSymbols.randomName()
    var color: Color = ColorOptions.random()
    var title = ""
    var tasks = [EventTask(text: "")]
    var date = Date.now
    /*#-code-walkthrough(2.eventProperties)*/

    /*#-code-walkthrough(2.computedProperties)*/
    /*#-code-walkthrough(2.otherProperties)*/
    var containsEmptyTextCount: Int {
        tasks.filter { $0.text.isEmpty }.count
    }
    
    var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    /*#-code-walkthrough(2.otherProperties)*/
    
    /*#-code-walkthrough(2.isPast)*/
    var isPast: Bool {
        date < Date.now
    }
    /*#-code-walkthrough(2.isPast)*/
    
    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
    }
    
    var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }
    
    var isDistant: Bool {
        date >= Date().thirtyDaysOut
    }
    /*#-code-walkthrough(2.computedProperties)*/

    static var example = Event(
        symbol: "case.fill",
        title: "Sayulita Trip",
        tasks: [
            EventTask(text: "Buy plane tickets"),
            EventTask(text: "Get a new bathing suit"),
            EventTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5))
}

// Convenience methods for dates.
extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
