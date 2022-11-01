import Foundation
//#-learning-task(eventTask)

/*#-code-walkthrough(3.eventTask)*/
struct EventTask: Identifiable, Hashable {
    /*#-code-walkthrough(3.eventTask)*/
    /*#-code-walkthrough(3.properties)*/
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
    /*#-code-walkthrough(3.properties)*/
}
