//
//  String+Extension.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation

extension String {
    
    public func toMovieGenre() -> String {
        switch self {
        case Config.MOVIE_GENRE_ACTION:
            return "Action"
        case Config.MOVIE_GENRE_ADVENTURE:
            return "Adventure"
        case Config.MOVIE_GENRE_ANIMATION:
            return "Animation"
        case Config.MOVIE_GENRE_COMEDY:
            return "Comedy"
        case Config.MOVIE_GENRE_CRIME:
            return "Crime"
        case Config.MOVIE_GENRE_DOCUMENTARY:
            return "Documentary"
        case Config.MOVIE_GENRE_DRAMA:
            return "Drama"
        case Config.MOVIE_GENRE_FAMILY:
            return "Family"
        case Config.MOVIE_GENRE_FANTASY:
            return "Fantasy"
        case Config.MOVIE_GENRE_HISTORY:
            return "History"
        case Config.MOVIE_GENRE_HORROR:
            return "Horror"
        case Config.MOVIE_GENRE_MUSIC:
            return "Music"
        case Config.MOVIE_GENRE_MYSTERY:
            return "Mystery"
        case Config.MOVIE_GENRE_ROMANCE:
            return "Romance"
        case Config.MOVIE_GENRE_SCIFI:
            return "Science-Fiction"
        case Config.MOVIE_GENRE_TV_MOVIE:
            return "TV Movie"
        case Config.MOVIE_GENRE_THRILLER:
            return "Thriller"
        case Config.MOVIE_GENRE_WAR:
            return "War"
        case Config.MOVIE_GENRE_WESTERN:
            return "Western"
        default:
            return ""
        }
    }
    
    public func toTVGenre() -> String {
        switch self {
        case Config.TV_GENRE_ACTION_ADVENTURE:
            return "Action Adventure"
        case Config.TV_GENRE_ANIMATION:
            return "Animation"
        case Config.TV_GENRE_COMEDY:
            return "Comedy"
        case Config.TV_GENRE_CRIME:
            return "Crime"
        case Config.TV_GENRE_DOCUMENTARY:
            return "Documentary"
        case Config.TV_GENRE_DRAMA:
            return "Drama"
        case Config.TV_GENRE_FAMILY:
            return "Family"
        case Config.TV_GENRE_KIDS:
            return "Kids"
        case Config.TV_GENRE_MYSTERY:
            return "Mystery"
        case Config.TV_GENRE_NEWS:
            return "News"
        case Config.TV_GENRE_REALITY:
            return "Reality"
        case Config.TV_GENRE_SCIFI_FANTASY:
            return "Sci-Fi & Fantasy"
        case Config.TV_GENRE_SOAP:
            return "Soap Opera"
        case Config.TV_GENRE_TALK:
            return "Talkshow"
        case Config.TV_GENRE_WAR_POLITICS:
            return "War and Politics"
        case Config.TV_GENRE_WESTERN:
            return "Western"
        default:
            return ""
        }
    }
}
