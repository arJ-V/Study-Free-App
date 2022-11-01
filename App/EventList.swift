import SwiftUI
//#-learning-task(eventList)

/*#-code-walkthrough(5.eventList)*/
struct EventList: View {
    /*#-code-walkthrough(5.eventList)*/
    /*#-code-walkthrough(5.eventData)*/
    @EnvironmentObject var eventData: EventData
    /*#-code-walkthrough(5.eventData)*/
    @State private var isAddingNewEvent = false
    @State private var newEvent = Event()
    
    var body: some View {
        
        /*#-code-walkthrough(5.listForEach)*/
        List {
            ForEach(Period.allCases) { period in
                /*#-code-walkthrough(5.listForEach)*/
                /*#-code-walkthrough(5.checkForEvents)*/
                if !eventData.sortedEvents(period: period).isEmpty {
                    /*#-code-walkthrough(5.checkForEvents)*/
                    /*#-code-walkthrough(5.listSection)*/
                    Section(content: {
                        ForEach(eventData.sortedEvents(period: period)) { $event in
                            /*#-code-walkthrough(5.listSection)*/
                            /*#-code-walkthrough(5.eventView)*/
                            NavigationLink {
                                EventEditor(event: $event)
                            } label: {
                                EventRow(event: event)
                            }
                            /*#-code-walkthrough(5.eventView)*/
                            /*#-code-walkthrough(5.deleteEvents)*/
                            .swipeActions {
                                Button(role: .destructive) {
                                    eventData.delete(event)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            /*#-code-walkthrough(5.deleteEvents)*/
                        }
                    }, header: {
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    })
                }
            }
        }
        .navigationTitle("Study Free!")
        .toolbar {
            ToolbarItem {
                Button {
                    newEvent = Event()
                    isAddingNewEvent = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewEvent) {
            NavigationView {
                EventEditor(event: $newEvent, isNew: true)
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventList().environmentObject(EventData())

        }
    }
}
