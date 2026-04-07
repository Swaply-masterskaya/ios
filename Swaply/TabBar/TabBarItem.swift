//
//  TabBarItem.swift
//  Swaply
//
//  Created by Георгий on 06.04.2026.
//

import UIKit

// пока на иконку профиля заглушку повесил, т.к. профиль это наверное другая задача, и когда уже будет ясно из чего брать - подгоню

enum TabBarItem: Int, CaseIterable {
    case home = 0
    case likes
    case projects
    case chats
    case profile
    var title: String {
        switch self {
        case .home: return "Главная"
        case .likes: return "Лайки"
        case .projects: return "Проекты"
        case .chats: return "Чаты"
        case .profile: return "Профиль"
        }
    }
    var defaultImage: UIImage? {
        switch self {
        case .home: return AppImages.iconTabBarHome
        case .likes: return AppImages.iconTabBarLikes
        case .projects: return AppImages.iconTabBarProjects
        case .chats: return AppImages.iconTabBarChats
        case .profile: return AppImages.logoBlack
        }
    }
    var selectedImage: UIImage? {
        switch self {
        case .home: return AppImages.iconTabBarHomeFilled
        case .likes: return AppImages.iconTabBarLikesFilled
        case .projects: return AppImages.iconTabBarProjectsFilled
        case .chats: return AppImages.iconTabBarChatsFilled
        case .profile: return AppImages.logoOrange
        }
    }
}
