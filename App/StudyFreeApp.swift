import SwiftUI
//#-learning-task(eventPlannerApp)

@main
struct DatePlannerApp: App {
    /*#-code-walkthrough(1.stateObject)*/
    @StateObject private var eventData = EventData()
    /*#-code-walkthrough(1.stateObject)*/

    var body: some Scene {
        WindowGroup {
            /*#-code-walkthrough(1.navigationView)*/
            NavigationView {
                EventList()
                /*#-code-walkthrough(1.textPlaceholder)*/
                Text("Select an Event")
                    .foregroundStyle(.secondary)
                /*#-code-walkthrough(1.textPlaceholder)*/
            }
            /*#-code-walkthrough(1.navigationView)*/
            /*#-code-walkthrough(1.environmentObject)*/
            .environmentObject(eventData)
            /*#-code-walkthrough(1.environmentObject)*/

        }
    }
}
