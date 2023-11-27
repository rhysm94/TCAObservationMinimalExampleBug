//
//  OtherFeature.swift
//
//
//  Created by Rhys Morgan on 27/11/2023.
//

import ComposableArchitecture

@Reducer
struct OtherFeature: Reducer {
	@ObservableState
	struct State: Equatable {
		var name: String

		init(name: String) {
			self.name = name
		}
	}

	enum Action {
		case setName(String)
	}

	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .setName(let name):
				state.name = name
				return .none
			}
		}
	}
}
