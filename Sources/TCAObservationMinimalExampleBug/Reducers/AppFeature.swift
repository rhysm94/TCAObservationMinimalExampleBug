//
//  AppFeature.swift
//
//
//  Created by Rhys Morgan on 27/11/2023.
//

import ComposableArchitecture

@Reducer
struct AppFeature: Reducer {
	@ObservableState
	struct State: Equatable {
		var path: StackState<Path.State> = StackState()
		var history: [String] = []
	}

	enum Action {
		case goToNonTCAFeature
		case goToOtherFeature
		case path(StackAction<Path.State, Path.Action>)
	}

	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .goToNonTCAFeature:
				state.path.append(.notTCAFeature(state.history))
				return .none

			case .goToOtherFeature:
				state.path.append(.otherFeature(.init(name: "")))
				return .none

			case let .path(.element(id: _, action: .otherFeature(.setName(name)))):
				state.history.append(name)
				return .none

			default:
				return .none
			}
		}
		.forEach(\.path, action: \.path) {
			Path()
		}
	}
}
