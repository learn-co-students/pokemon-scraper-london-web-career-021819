require 'pry'

class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  @@all = []

  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
    @@all << self
  end

  def self.all
    @@all
  end


  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?)", name, type)
  end


  def self.find(id, db)
    #The execute() method wraps everything it is returning in an array
    pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    #binding.pry # => [[1, "Pikachu", "electric"]] => use .flatten
    name = pokemon[1]
    type = pokemon[2]
    hp = pokemon[3]
    pokemon_instance = Pokemon.new(id: id, name: name, type: type, hp: hp, db: db)
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
  end


end
