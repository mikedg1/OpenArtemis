//
//  UserAgents.swift
//  OpenArtemis
//
//  Created by Michael DiGovanni on 11/4/24.
//
import Foundation

class UserAgents {
    enum UserAgentType {
        case robot, browser, httpLibrary
    }
    
    private let userAgents: [UserAgentType: [String]] = [
        .robot: [
            "Googlebot/2.1 (+http://www.google.com/bot.html)",
            "Bingbot/2.0 (+http://www.bing.com/bingbot.htm)",
            "Slurp/3.0 (yahoo)",
            "DuckDuckBot/1.0; (+http://duckduckgo.com/duckduckbot.html)",
            "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
            "Mozilla/5.0 (compatible; Bingbot/2.0; +http://www.bing.com/bingbot.htm)",
            "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)",
            "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)",
            "Mozilla/5.0 (compatible; DuckDuckBot/1.0; +http://duckduckgo.com/duckduckbot.html)",
            "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)",
            "Mozilla/5.0 (compatible; Sogou web spider/4.0; +http://www.sogou.com/docs/help/webmasters.htm#07)",
            "Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)",
            "Mozilla/5.0 (Linux; Android 4.4.2; Nexus 7 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.136 Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
            "Mozilla/5.0 (compatible; Applebot/0.3; +http://www.apple.com/go/applebot)",
            "Mozilla/5.0 (compatible; facebookexternalhit/1.1; +http://www.facebook.com/externalhit_uatext.php)",
            "Mozilla/5.0 (compatible; Facebot/1.0; +http://www.facebook.com/externalhit_uatext.php)",
            "Twitterbot/1.0",
            "Mozilla/5.0 (compatible; Mediapartners-Google/2.1; +http://www.google.com/bot.html)",
            "AdsBot-Google (+http://www.google.com/adsbot.html)",
            "FeedFetcher-Google; (+http://www.google.com/feedfetcher.html)",
            "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
            "Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_5 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/9.0 Mobile/13G36 Safari/601.1 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
            "Mozilla/5.0 (compatible; MJ12bot/v1.4.8; http://mj12bot.com/)",
            "Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)"
        ],
        .browser: [
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0",
            "Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_3_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1 Safari/605.1.15",
            "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36",
            "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0",
            "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7; en-us) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Safari/605.1.15",
            "Mozilla/5.0 (Linux; Android 9; SM-J530F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Mobile Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; x64; rv:88.0) Gecko/20100101 Firefox/88.0",
            "Mozilla/5.0 (iPad; CPU OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:63.0) Gecko/20100101 Firefox/63.0",
            "Mozilla/5.0 (iPhone; CPU iPhone OS 13_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.2 Mobile/15E148 Safari/605.1",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36 Edg/92.0.902.55"
        ],
        .httpLibrary: [
            "curl/7.64.1",
            "Wget/1.20.3 (linux-gnu)",
            "Python-urllib/3.7",
            "HttpClient/4.5.2 (Java/1.8.0_161)",
            "libwww-perl/6.36",
            "Go-http-client/1.1",
            "okhttp/3.12.1",
            "Java/1.8.0_202",
            "axios/0.21.1",
            "restsharp/106.11.7.0",
            "Apache-HttpClient/4.5.10 (Java/1.8.0_221)",
            "PostmanRuntime/7.26.8",
            "Dart/2.10 (dart:io)"
        ]
    ]
    
    func getUserAgent(type: UserAgentType) -> String? {
        guard let agents = userAgents[type] else { return nil }
        return agents.randomElement()
    }
    
    func getUserAgent(types: [UserAgentType]) -> String? {
        var combinedUserAgents: [String] = []
        for type in types {
            if let agents = userAgents[type] {
                combinedUserAgents.append(contentsOf: agents)
            }
        }
        return combinedUserAgents.randomElement()
    }
}
