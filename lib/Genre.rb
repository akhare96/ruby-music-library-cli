class Genre
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

    def self.create(genre)
        new_genre = Genre.new(genre)
    end

    def self.destroy_all
        self.all.clear
    end

    def songs
        Song.all.select {|song| song.genre == self}
    end

    def add_song(song)
        song.genre = self unless song.genre
    end

    def artists
        (songs.collect {|song| song.artist}).uniq
    end


end