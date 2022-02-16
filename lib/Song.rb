require 'pry'
class Song

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self) unless genre.songs.include?(self)
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end

    def self.create(title)
        song = Song.new(title)
        song
    end

    def self.find_by_name(name)
        all.find{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    # (Thundercat - For Love I Come - dance.mp3)
    def self.new_from_filename(filename)
        artist = (filename.split(" - ")[0])
        song = (filename.split(" - ")[1])
        genre = (filename.split(" - ")[2]).gsub(".mp3", "")
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(genre)
        Song.new(song, artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename)
    end


    def self.destroy_all
        self.all.clear
    end


end
