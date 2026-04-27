//
//  Resources.swift
//  Swaply
//
//  Created by Георгий on 14.04.2026.
//

import UIKit

enum Resources {

    enum TabBar {
        static let homeTitle = "Главная"
        static let likesTitle = "Лайки"
        static let projectsTitle = "Проекты"
        static let chatsTitle = "Чаты"
        static let profileTitle = "Профиль"

        static let homeDefaultIcon = AppImages.iconTabBarHome
        static let likesDefaultIcon = AppImages.iconTabBarLikes
        static let projectsDefaultIcon = AppImages.iconTabBarProjects
        static let chatsDefaultIcon = AppImages.iconTabBarChats
        static let profileDefaultIcon = AppImages.logoBlack

        static let homeSelectedIcon = AppImages.iconTabBarHomeFilled
        static let likesSelectedIcon = AppImages.iconTabBarLikesFilled
        static let projectsSelectedIcon = AppImages.iconTabBarProjectsFilled
        static let chatsSelectedIcon = AppImages.iconTabBarChatsFilled
        static let profileSelectedIcon = AppImages.logoOrange
    }

    enum WelcomeScreen {
        static let enterButtonTitle = "Войти"
        static let registerButtonTitle = "Зарегистрироваться"
        static let skipButtonTitle = "Пропустить"
    }

    enum Common {
        static let respondButtonTitle = "Откликнуться"
        static let responsesButtonTitle = "Отклики"
        static let homeButtonTitle = "Главная"
        static let okButtonTitle = "Хорошо"
        static let backButtonTitle = "Назад"
        static let sendButtonTitle = "Отправить"
        static let continueButtonTitle = "Продолжить"
        static let writeButtonTitle = "Написать"
    }
}
