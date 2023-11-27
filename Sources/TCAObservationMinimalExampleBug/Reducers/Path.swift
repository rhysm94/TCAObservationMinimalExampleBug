//
//  Path.swift
//
//
//  Created by Rhys Morgan on 27/11/2023.
//

import ComposableArchitecture

extension AppFeature {
	@Reducer
	struct Path: Reducer {
		@ObservableState
		enum State: Equatable {
			case notTCAFeature([String])
			case otherFeature(OtherFeature.State)
		}

		enum Action {
			case notTCAFeature(Never)
			case otherFeature(OtherFeature.Action)
		}

		var body: some ReducerOf<Self> {
			Scope(state: \.otherFeature, action: \.otherFeature) {
				OtherFeature()
			}
		}
	}
}
