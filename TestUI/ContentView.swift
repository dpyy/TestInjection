

import Combine
import SwiftUI

enum Destination {
    case firstPage
    case secondPage
}

enum Category: Int, Hashable, CaseIterable, Identifiable, Codable {
    case dessert
    case pancake
    case salad
    case sandwich

    var id: Int { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .dessert:
            return "Dessert"
        case .pancake:
            return "Pancake"
        case .salad:
            return "Salad"
        case .sandwich:
            return "Sandwich"
        }
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func gotoHomePage() {
        path.removeLast(path.count)
    }

    func tapOnEnter() {
        path.append(Destination.firstPage)
    }

    func tapOnFirstPage() {
        path.append(Destination.secondPage)
    }

    func tapOnSecondPage() {
        path.removeLast()
    }

    func test() {
        path.removeLast(path.count)
        path.append(2)
    }
}

class Test :ObservableObject {
    var name = "test"
}

struct ContentView: View {
    @State var selectedCategory: Category?
    var categories = Category.allCases
    @ObservedObject var coordinator = Coordinator()
    @StateObject var test = Test()

    var body: some View {
        NavigationSplitView {
            List(categories, selection: $selectedCategory) { category in
                NavigationLink(category.localizedName, value: category)
            }
        } detail: {
            NavigationStack(path: $coordinator.path) {
                switch selectedCategory {
                case .dessert:
                    Text(selectedCategory!.localizedName)
                case .pancake:
                    VStack {
                        Text("Navigation stack")
                            .padding()
                        NavigationLink("NavigationLink to enter first page", value: Destination.firstPage)
                            .padding()
                        NavigationLink("NavigationLink to enter second page", value: Destination.secondPage)
                            .padding()
                    }
                    .navigationDestination(for: Destination.self) { destination in
                        if destination == .firstPage {
                            FirstPage()
                        } else {
                            SecondPage()
                        }
                    }
                case .salad: Text(selectedCategory!.localizedName)
                case .sandwich: Text(selectedCategory!.localizedName)
                case .none: Text("hi")
                }
            }.environmentObject(test)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
