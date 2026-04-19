//
//  CustomSearchFieldDelegate.swift
//  Swaply
//
//  Created by Алина on 18.04.2026.
//

import Foundation

protocol CustomSearchFieldDelegate: AnyObject {
	func customSearchField(_ customSearchField: CustomSearchField, didChangeText text: String)
	func customSearchFieldDidTapSearch(_ customSearchField: CustomSearchField, text: String)
	func customSearchFieldDidTapClose(_ customSearchField: CustomSearchField)
}
