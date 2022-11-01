import SwiftUI

struct EventEditor: View {
    @Binding var event: Event
    @State var isNew = false
    
    @State private var isDeleted = false
    @EnvironmentObject var eventData: EventData
    @Environment(\.dismiss) private var dismiss
    
    @State private var eventCopy = Event()
    
    private var isEventDeleted: Bool {
        !eventData.exists(eventCopy) && !isNew
    }
    
    var body: some View {
        VStack {
            EventDetail(event: $eventCopy, isDeleted: $isDeleted, isNew: $isNew)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem {
                        Button {
                            if isNew {
                                eventData.events.append(eventCopy)
                                dismiss()
                            }
                        } label: {
                            Text(isNew ? "Add" : "")
                        }
                        .disabled(eventCopy.title.isEmpty)
                    }
                }
                .onAppear {
                    eventCopy = event
                }
                .onChange(of: eventCopy){ _ in
                    if !isDeleted {
                        event = eventCopy
                    }
                }
        }
        .overlay(alignment: .center) {
            if isEventDeleted {
                Color(UIColor.systemBackground)
                Text("Event Deleted. Select an Event.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct EventEditor_Previews: PreviewProvider {
    static var previews: some View {
        EventEditor(event: .constant(Event()), isNew: true)
            .environmentObject(EventData())
    }
}
