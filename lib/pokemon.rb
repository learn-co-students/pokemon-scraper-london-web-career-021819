require 'pry'
class Pokemon

  attr_reader :id, :type, :name, :db, :hp


  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?);", name,type )
  end

  def self.find(id, db)
    arr = db.execute("SELECT * FROM pokemon WHERE id = ?;", id).flatten
    # binding.pry
    Pokemon.new(id: arr[0], name: arr[1], type: arr[2], db: db, hp: arr[3])
  end

  def alter_hp(hp ,db)
    db.execute("UPDATE pokemon SET hp = ? WHERE pokemon.id = ?", hp, self.id)
  end

end
