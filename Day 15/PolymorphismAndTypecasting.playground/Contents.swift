import UIKit

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots."
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = name
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots."
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots."
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studio")
var fearless = StudioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHO", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

// Typecasting
// as? - optional typecasting
// as! - forced typecasting
for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

var tswift = StudioAlbum(name: "TS", studio: "Castles")
var fless = StudioAlbum(name: "SN", studio: "Aimee")

var allBums: [Album] = [tswift, fless]
    
for album in allBums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}

// or we can simplify it by writing it like this

for album in allBums as! [StudioAlbum] {
    print(album.studio)
}

// optional downcasting
for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}

//converting common types
let number = 5
let text = String(number)
print(text)
