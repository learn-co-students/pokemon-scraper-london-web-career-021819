class Pokemon
    attr_reader :id, :name, :type, :db, :hp

    def initialize(attributes)
        @id = attributes[:id]
        @name = attributes[:name]
        @type = attributes[:type]
        @db = attributes[:db]
        @hp = attributes[:hp]
    end


    def self.save(pokemon, type, database)
        database.execute "INSERT INTO  pokemon (name, type) VALUES (?, ?)", [pokemon, type]
    end

    def self.find(id, database)
        poke = database.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id).flatten
        poke_hash ={}
        poke_hash[:id] = poke[0]
        poke_hash[:name] = poke[1]
        poke_hash[:type] = poke[2]
        poke_hash[:db] = [database]
        poke_hash[:hp] = poke[3]
        Pokemon.new(poke_hash)
    end

    def alter_hp(new_hp, database)
        database.execute("UPDATE pokemon SET hp = (?) WHERE id = (?)", [new_hp, @id])
    end
end
