dinosaurs = [
    {
        name: 'Tyrannosaurus Rex',
        age: 66000000,
        diet: 'Canivore',
        enjoys: 'Visits to the dentist for his many large serated teeth.',
        image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
    },
    {
        name: 'Triceratops',
        age: 69000000,
        diet: 'Herbavore(Vegan)',
        enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
        image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649'
    },
    {
        name: 'Velociraptor',
        age: 65000000,
        diet: 'Canivore',
        enjoys: 'Loves to take long runs off of cliffs in a futile attempt to learn to fly.',
        image: 'https://res.cloudinary.com/dk-find-out/image/upload/q_80,w_1920,f_auto/Velociraptor_u4hjbq.jpg'
    },
    {
        name: 'Pteradactyl',
        age: 66000000,
        diet: 'Canivore',
        enjoys: 'An active individual who enjoys sushi on the fly.',
        image: 'https://www.osc.org/wp-content/uploads/2020/09/Pterodactyls-are-carnivores-800x800.jpg'
    },
]

dinosaurs.each do |dinosaur|
    Dinosaur.create dinosaur
    puts "Creating dinosaur #{dinosaur}"
end

# Template:
#     {
#         name: '',
#         age: ,
#         diet: '',
#         enjoys: '',
#         image: ''
#     },