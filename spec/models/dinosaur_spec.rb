require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
    it 'should validate all attributes are present' do
        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors).to_not be_empty
        expect(dino.errors).to_not include "can't be blank" 
         
    end

    it 'should validate name' do
        dino = Dinosaur.create(
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:name]).to_not be_empty
        expect(dino.errors[:name]).to include "can't be blank" 
    end

    it 'should validate age' do
        dino = Dinosaur.create(
        name: 'Triceratops',
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:age]).to_not be_empty
        expect(dino.errors[:age].length).to eq 2
    end   

    it 'should validate diet' do
        dino = Dinosaur.create(
        name: 'Triceratops',
        age: 69000000,
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:diet]).to_not be_empty
        expect(dino.errors[:diet]).to include "can't be blank"
    end

    it 'should validate enjoys' do
        dino = Dinosaur.create(
        name: 'Triceratops',
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:enjoys]).to_not be_empty
        expect(dino.errors[:enjoys]).to include "can't be blank"
    end

    it 'should validate image' do
        dino = Dinosaur.create(
        name: 'Triceratops',
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',)
        expect(dino.errors[:image]).to_not be_empty
        expect(dino.errors[:image]).to include "can't be blank"
    end

    it 'is not valid if name is less than 5 characters long' do
        dino = Dinosaur.create(
        name: 'Tri',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:name]).to_not be_empty
        expect(dino.errors[:name]).to include "is too short (minimum is 5 characters)" 
    end

    it 'is not valid if age is not in range' do
        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 59000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:age]).to_not be_empty
        expect(dino.errors[:age].length).to eq 1 
        expect(dino.errors[:age]).to include "is too short (minimum is 60000000 characters)"
    end

    it 'is not valid if diet is less than 4 characters long' do
        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Mea',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:diet]).to_not be_empty
        expect(dino.errors[:diet]).to include "is too short (minimum is 4 characters)" 
    end

    it 'is not valid if enjoys is less than 10 characters long' do
        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:enjoys]).to_not be_empty
        expect(dino.errors[:enjoys]).to include "is too short (minimum is 10 characters)" 
    end

    it 'is not valid if image is less than 10 characters long' do
        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://')

        expect(dino.errors[:image]).to_not be_empty
        expect(dino.errors[:image]).to include "is too short (minimum is 10 characters)" 
    end

    it 'does not allow duplicate names' do
        Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:name]).to be_empty
        expect(dino.errors[:name]).to_not include "has already been taken" 
    end

    it 'does not allow duplicate image' do
        Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        dino = Dinosaur.create(
        name: 'Triceratops',    
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649')

        expect(dino.errors[:image]).to be_empty
        expect(dino.errors[:image]).to_not include "has already been taken" 
    end

end




# {
#     name: 'Triceratops',
#     age: 69000000,
#     diet: 'Herbavore(Vegan)',
#     enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
#     image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649'
# },
