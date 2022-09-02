//
//  Config.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation

struct Config {
    
    static let URL_BASE = "https://api.themoviedb.org/3/"
    static let URL_IMAGE_BASE = "https://image.tmdb.org/t/p/w500"
    static let API_KEY = ""
    
    // MARK: Movies URL
    static let URL_MOVIES_GET_DETAILS: (String) -> (String) = { id in URL_BASE + "movie/\(id)?api_key=\(API_KEY)&language=en-US" }
    static let URL_MOVIES_GET_ALTERNATIVE_TITLES: (String) -> (String) = { id in URL_BASE + "movie/\(id)/alternative_titles?api_key=\(API_KEY)" }
    static let URL_MOVIES_GET_CREDITS: (String) -> (String) = { id in URL_BASE + "movie/\(id)/credits?api_key=\(API_KEY)&language=en-US" }
    static let URL_MOVIES_GET_IMAGES: (String) -> (String) = { id in URL_BASE + "movie/\(id)/images?api_key=\(API_KEY)&language=en-US" }
    static let URL_MOVIES_GET_KEYWORDS: (String) -> (String) = { id in URL_BASE + "movie/\(id)/keywords?api_key=\(API_KEY)" }
    static let URL_MOVIES_GET_RELEASE_DATES: (String) -> (String) = { id in URL_BASE + "movie/\(id)/release_dates?api_key=\(API_KEY)" }
    static let URL_MOVIES_GET_REVIEWS: (String, String) -> (String) = { (id, page) in URL_BASE + "movie/\(id)/reviews?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_SIMILIAR_MOVIES: (String) -> (String) = { id in URL_BASE + "movie/\(id)/similar?api_key=\(API_KEY)&language=en-US&page=1" }
    static let URL_MOVIES_GET_LATEST = URL_BASE + "movie/latest?api_key=\(API_KEY)&language=en-US"
    static let URL_MOVIES_GET_NOW_PLAYING: (String) -> (String) = { page in URL_BASE + "movie/now_playing?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_POPULAR: (String) -> (String) = { page in URL_BASE + "movie/popular?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_TOP_RATED: (String) -> (String) = { page in URL_BASE + "movie/top_rated?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_UPCOMING: (String) -> (String) = { page in URL_BASE + "movie/upcoming?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    
    // MARK: TV Shows URL
    static let URL_TV_GET_DETAILS: (String) -> (String) = { id in URL_BASE + "tv/\(id)?api_key=\(API_KEY)&language=en-US" }
    static let URL_TV_GET_ALTERNATIVE_TITLE: (String) -> (String) = { id in URL_BASE + "tv/\(id)/alternative_titles?api_key=\(API_KEY)&language=en-US" }
    static let URL_TV_GET_CREDITS: (String) -> (String) = { id in URL_BASE + "tv/\(id)/credits?api_key=\(API_KEY)&language=en-US" }
    static let URL_TV_GET_IMAGES: (String) -> (String) = { id in URL_BASE + "tv/\(id)/images?api_key=\(API_KEY)&language=en-US" }
    static let URL_TV_GET_KEYWORDS: (String) -> (String) = { id in URL_BASE + "tv/\(id)/keywords?api_key=\(API_KEY)" }
    static let URL_TV_GET_REVIEWS: (String, String) -> (String) = { (id, page) in URL_BASE + "tv/\(id)/reviews?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_SIMILIAR: (String, String) -> (String) = { (id, page) in URL_BASE + "tv/\(id)/similar?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_LATEST = URL_BASE + "tv/latest?api_key=\(API_KEY)&language=en-US"
    static let URL_TV_GET_AIRING_TODAY: (String) -> (String) = { page in URL_BASE + "tv/airing_today?api_key=\(API_KEY)&language=en-US&page=\(page)"}
    static let URL_TV_GET_ON_THE_AIR: (String) -> (String) = { page in URL_BASE + "tv/on_the_air?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_POPULAR: (String) -> (String) = { page in URL_BASE + "tv/popular?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_TOP_RATED: (String) -> (String) = { page in URL_BASE + "tv/top_rated?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    
    // MARK: TV Seasons URL
    static let URL_SEASONS_GET_DETAILS: (String, String) -> (String) = { (id, season) in URL_BASE + "tv/\(id)/season/\(season)?api_key=\(API_KEY)&language=en-US" }
    static let URL_SEASONS_GET_CREDITS: (String, String) -> (String) = { (id, season) in URL_BASE + "tv/\(id)/season/\(season)/credits?api_key=\(API_KEY)&language=en-US" }
    static let URL_SEASONS_GET_IMAGES: (String, String) -> (String) = { (id, season) in URL_BASE + "tv/\(id)/season/\(season)/images?api_key=\(API_KEY)&language=en-US" }
    
    // MARK: TV Episodes URL
    static let URL_EPISODES_GET_DETAILS: (String, String, String) -> (String) = { (id, season, episode) in URL_BASE + "tv/\(id)/season/\(season)/episode/{episode_number}?api_key=\(API_KEY)&language=en-US" }
    static let URL_EPISODES_GET_CREDITS: (String, String, String) -> (String) = { (id, season, episode) in URL_BASE + "tv/\(id)/season/\(season)/episode/{episode_number}/credits?api_key=\(API_KEY)&language=en-US" }
    static let URL_EPISODES_GET_IMAGES: (String, String, String) -> (String) = { (id, season, episode) in URL_BASE + "tv/\(id)/season/\(season)/episode/{episode_number}/images?api_key=\(API_KEY)" }
    
    // MARK: People URL
    static let URL_PEOPLE_GET_DETAILS: (String) -> (String) = { id in URL_BASE + "person/\(id)?api_key=\(API_KEY)&language=en-US" }
    static let URL_PEOPLE_GET_MOVIE_CREDITS: (String) -> (String) = { id in URL_BASE + "person/\(id)/movie_credits?api_key=\(API_KEY)&language=en-US" }
    static let URL_PEOPLE_GET_TV_CREDITS: (String) -> (String) = { id in URL_BASE + "person/\(id)/tv_credits?api_key=\(API_KEY)&language=en-US" }
    static let URL_PEOPLE_GET_IMAGES: (String) -> (String) = { id in URL_BASE + "person/\(id)images?api_key=\(API_KEY)" }
    static let URL_PEOPLE_GET_LATEST = URL_BASE + "person/latest?api_key=\(API_KEY)&language=en-US"
    static let URL_PEOPLE_GET_POPULAR: (String) -> (String) = { page in URL_BASE + "person/popular?api_key=\(API_KEY)&language=en-US&page=\(page)" }
    
    // MARK: Reviews URL
    static let URL_REVIEWS_GET_DETAILS: (String) -> (String) = { id in URL_BASE + "review/\(id)?api_key=\(API_KEY)" }
    
    // MARK: Search URL
    static let URL_SEARCH_GET_COLLECTIONS: (String, String) -> (String) = { (query, page) in URL_BASE + "search/collection?api_key=\(API_KEY)&language=en-US&query=\(query)&page=\(page)" }
    static let URL_SEARCH_GET_KEYWORDS: (String, String) -> (String) = { (query, page) in URL_BASE + "search/keyword?api_key=\(API_KEY)&query=\(query)&page=\(page)" }
    static let URL_SEARCH_GET_MOVIES: (String, String) -> (String) = { (query, page) in URL_BASE + "search/movie?api_key=\(API_KEY)&language=en-US&query=\(query)&page=\(page)&include_adult=false" }
    static let URL_SEARCH_GET_PEOPLE: (String, String) -> (String) = { (query, page) in URL_BASE + "search/person?api_key=\(API_KEY)&language=en-US&query=\(query)&page=\(page)&include_adult=false" }
    static let URL_SEARCH_GET_TV_SHOWS: (String, String) -> (String) = { (query, page) in URL_BASE + "search/tv?api_key=\(API_KEY)&language=en-US&page=\(page)&query=\(query)&include_adult=false" }
}

extension Config {
    // MARK: Movie Genres
    static let MOVIE_GENRE_ACTION = "28"
    static let MOVIE_GENRE_ADVENTURE = "12"
    static let MOVIE_GENRE_ANIMATION = "16"
    static let MOVIE_GENRE_COMEDY = "35"
    static let MOVIE_GENRE_CRIME = "80"
    static let MOVIE_GENRE_DOCUMENTARY = "99"
    static let MOVIE_GENRE_DRAMA = "18"
    static let MOVIE_GENRE_FAMILY = "10751"
    static let MOVIE_GENRE_FANTASY = "14"
    static let MOVIE_GENRE_HISTORY = "36"
    static let MOVIE_GENRE_HORROR = "27"
    static let MOVIE_GENRE_MUSIC = "10402"
    static let MOVIE_GENRE_MYSTERY = "9648"
    static let MOVIE_GENRE_ROMANCE = "10749"
    static let MOVIE_GENRE_SCIFI = "878"
    static let MOVIE_GENRE_TV_MOVIE = "10770"
    static let MOVIE_GENRE_THRILLER = "53"
    static let MOVIE_GENRE_WAR = "10752"
    static let MOVIE_GENRE_WESTERN = "37"
    
    static let MOVIE_GENRE_ALL = ["28", "12", "16", "35", "80", "99", "18", "10751", "14", "36", "27", "10402", "9648", "10749", "878", "10770", "53", "10752", "37"]
    
    // MARK: TV Genres
    static let TV_GENRE_ACTION_ADVENTURE = "10759"
    static let TV_GENRE_ANIMATION = "16"
    static let TV_GENRE_COMEDY = "35"
    static let TV_GENRE_CRIME = "80"
    static let TV_GENRE_DOCUMENTARY = "99"
    static let TV_GENRE_DRAMA = "18"
    static let TV_GENRE_FAMILY = "10751"
    static let TV_GENRE_KIDS  = "10762"
    static let TV_GENRE_MYSTERY = "9648"
    static let TV_GENRE_NEWS = "10763"
    static let TV_GENRE_REALITY = "10764"
    static let TV_GENRE_SCIFI_FANTASY = "10765"
    static let TV_GENRE_SOAP = "10766"
    static let TV_GENRE_TALK = "10767"
    static let TV_GENRE_WAR_POLITICS = "10768"
    static let TV_GENRE_WESTERN = "37"
    
    static let TV_GENRE_ALL = ["10759", "16", "35", "80", "99", "18", "10751", "10762", "9648", "10763", "10764", "10765", "10766", "10767", "10768", "37"]
}
