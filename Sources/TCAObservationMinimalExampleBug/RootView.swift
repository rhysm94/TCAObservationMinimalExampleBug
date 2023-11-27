//
//  RootView.swift
//  
//
//  Created by Rhys Morgan on 27/11/2023.
//

import ComposableArchitecture
import SwiftUI

struct NewRootView: View {
	@State var store: StoreOf<AppFeature>

	var body: some View {
		NavigationStack(
			path: $store.scope(state: \.path, action: \.path)
		) {
			MainView(store: store)
		} destination: { store in
			switch store.state {
			case .notTCAFeature:
				if let store = store.scope(state: \.notTCAFeature, action: \.notTCAFeature) {
					NonTCAFeatureView(history: store.withState { $0 })
				}

			case .otherFeature:
				if let store = store.scope(state: \.otherFeature, action: \.otherFeature) {
					OtherFeatureView(store: store)
				}
			}
		}
	}
}

struct RootView: View {
	let store: StoreOf<AppFeature>

	var body: some View {
		NavigationStackStore(
			store.scope(state: \.path, action: { .path($0) })
		) {
			MainView(store: store)
		} destination: { state in
			switch state {
			case .notTCAFeature:
				CaseLet(
					/AppFeature.Path.State.notTCAFeature,
					 action: AppFeature.Path.Action.notTCAFeature
				) { store in
					NonTCAFeatureView(history: store.withState { $0 })
				}

			case .otherFeature:
				CaseLet(
					/AppFeature.Path.State.otherFeature,
					 action: AppFeature.Path.Action.otherFeature
				) { store in
					OtherFeatureView(store: store)
				}
			}
		}
	}
}

struct MainView: View {
	let store: StoreOf<AppFeature>

	var body: some View {
		VStack {
			Button("Go to Non TCA Feature") {
				store.send(.goToNonTCAFeature)
			}

			Button("Go to Other Feature") {
				store.send(.goToOtherFeature)
			}
		}
	}
}

struct NonTCAFeatureView: View {
	let history: [String]

	var body: some View {
		VStack(alignment: .leading) {
			List(history, id: \.self) { name in
				Text(name)
			}
		}
	}
}

struct OtherFeatureView: View {
	let store: StoreOf<OtherFeature>

	var body: some View {
		Text("Other Feature!")
			.navigationTitle(Text("Other Feature"))
	}
}
