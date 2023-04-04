class Dinosaur < ApplicationRecord

    validates :name, :age, :diet, :enjoys, :image, presence: true
    validates :name, length: { minimum: 5 }
    # # Adding a minimum of four char to be inclusive of the following examples: Meat, Plants, Both
    validates :age, numericality: { in: 60000000..230000000 }
    validates :diet, length: { minimum: 4 }
    validates :enjoys, :image, length: { minimum: 10 } 
    validates :name, :image, uniqueness: true 
    
end
