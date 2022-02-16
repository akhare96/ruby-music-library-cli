class Artist
    extend Concerns::Findable

    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        save
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.create(artist_name)
        artist = Artist.new(artist_name)
    end

    def self.destroy_all
        self.all.clear
    end
     
    def songs
        Song.all.select {|song| song.artist == self}
    end

    def add_song(song)
        song.artist = self unless song.artist
    end

    def genres
        (songs.collect {|song| song.genre}).uniq
    end

end