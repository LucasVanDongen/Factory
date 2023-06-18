//
//  ContentView.swift
//  FactoryDemo
//
//  Created by Michael Long on 6/2/22.
//

import SwiftUI
import Factory

struct ContentView: View {

    //@InjectedObject(\.contentViewModel)
    @State var model: ContentViewModel = Container.shared.contentViewModel()

    var body: some View {
        List {
            Section("View Model Bindings") {
                HStack {
                    Text("Name")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("Name", text: $model.name)
                        .multilineTextAlignment(.trailing)
                }

                Button("Mutate") {
                    model.name += "z"
                }

                child()
            }

            Section("Navigation") {
                NavigationLink("Link") {
                    ContentView()
                }
            }

            Section("Crash Tests") {
                Button("Trigger Circular Dependency Crash") {
                    Container.testCircularDependencies()
                }
                Button("Promised Crash") {
                    let _ = Container.shared.promisedService()
                }
            }

            Section("Miscellaneous") {
                HStack {
                    Text("Testing")
                    Spacer()
                    Text(model.testing)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    @ViewBuilder func child() -> some View {
        ChildContentView(model: model)
            .foregroundColor(.secondary)
    }
    
}

struct innerView: View {
    var body: some View {
        Text("Hello")
            .foregroundColor(.red)
    }
}
struct outerView: View {
    var body: some View {
        innerView()
            .foregroundColor(.green)
    }
}

struct ChildContentView: View {
    //@ObservedObject
    var model: ContentViewModel
    var body: some View {
        Text(model.text() + " for \(model.name)")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Depends on preview context set in FactoryDemoApp+AutoRegister.swift
        ContentView()
    }
}

// Illustrates multiple
//struct ContentView_Previews2: PreviewProvider {
//    static var previews: some View {
//        Group {
//            let _ = Container.shared.myServiceType.register { MockServiceN(44) }
//            let model1 = ContentViewModel()
//            ContentView(model: InjectedObject(model1))
//
//            let _ = Container.shared.myServiceType.register { MockServiceN(88) }
//            let model2 = ContentViewModel()
//            ContentView(model: InjectedObject(model2))
//        }
//    }
//}
