//
//  TabBarItem.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

// TODO: пока на иконку профиля заглушку повесил, т.к. профиль это наверное другая задача, и когда уже будет ясно из чего брать - подгоню

enum TabBarItem: Int, CaseIterable {
    case home = 0
    case likes
    case projects
    case chats
    case profile

    // MARK: - Internal Properties

    var title: String {
        switch self {
        case .home: return Resources.TabBar.homeTitle
        case .likes: return Resources.TabBar.likesTitle
        case .projects: return Resources.TabBar.projectsTitle
        case .chats: return Resources.TabBar.chatsTitle
        case .profile: return Resources.TabBar.profileTitle
        }
    }

    var defaultImage: UIImage? {
        switch self {
        case .home: return Resources.TabBar.homeDefaultIcon
        case .likes: return Resources.TabBar.likesDefaultIcon
        case .projects: return Resources.TabBar.projectsDefaultIcon
        case .chats: return Resources.TabBar.chatsDefaultIcon
        case .profile: return Resources.TabBar.profileDefaultIcon
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .home: return Resources.TabBar.homeSelectedIcon
        case .likes: return Resources.TabBar.likesSelectedIcon
        case .projects: return Resources.TabBar.projectsSelectedIcon
        case .chats: return Resources.TabBar.chatsSelectedIcon
        case .profile: return Resources.TabBar.profileSelectedIcon
        }
    }
}
