require 'rails_helper'

RSpec.describe "Dinosaurs", type: :request do
    describe "GET /index" do
        it 'gets a list of dinosaurs' do
        #Creating an instance for the testing model
        Dinosaur.create(
            name: 'Tyrannosaurus Rex',
            age: 60000001,
            diet: 'Canivore',
            enjoys: 'Visits to the dentist for his many large serated teeth.',
            image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
        )
        #HTTP request
        get '/dinosaurs'
        #Requesting the response in JSON and storing it in a variable
        dinosaur = JSON.parse(response.body)
        #Checking response to be a HTTP status code of 200
        expect(response).to have_http_status(200)
        #Check that dinosaur is present in the table
        expect(dinosaur.length).to eq 1
        end
    end

    describe "POST / create" do
        it 'creates a dinosaur' do
        dinosaur_params = {
            dinosaur: {
                name: 'Tyrannosaurus Rex',
                age: 66000000,
                diet: 'Canivore',
                enjoys: 'Visits to the dentist for his many large serated teeth.',
                image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
            }
        }

        #HTTP request
        post '/dinosaurs', params: dinosaur_params

        #Requesting the response in JSON and storing it in a variable
        expect(response).to have_http_status(200)
        #Searching for last instance created in database
        dinosaur = Dinosaur.last
        #Check that correct attributes are attached to dinosaur
        expect(dinosaur.name).to eq 'Tyrannosaurus Rex'
        expect(dinosaur.age).to eq 66000000
        expect(dinosaur.diet).to eq 'Canivore'
        expect(dinosaur.enjoys).to eq 'Visits to the dentist for his many large serated teeth.'
        expect(dinosaur.image).to eq 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
        end
    end

    describe "PATCH / update" do
        it 'updates a dinoasaur' do
        dinosaur_params = {
            dinosaur: {
                name: 'Tyrannosaurus Rex',
                age: 66000000,
                diet: 'Canivore',
                enjoys: 'Visits to the dentist for his many large serated teeth.',
                image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
            }
        }

        #HTTP request
        post '/dinosaurs', params: dinosaur_params
        #Storing the last created instance into a variable. .last is better because if you use .first and there are multiple entries in the database, it can potentially pull a different entry than the one created in the testing method.
        dinoasaur = Dinosaur.last

        #Updated instance
        updated_dinosaur_params = {
            dinosaur: {
                name: 'Tyrannosaurus Rex',
                age: 67000000,
                diet: 'Canivore',
                enjoys: 'Visits to the dentist for his many large serated teeth.',
                image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
            }
        }

        #HTTP request using Ruby string interpolation to update a specific id
        patch "/dinosaurs/#{dinoasaur.id}", params: updated_dinosaur_params
        #Storing the update dinosaur instance into a variable
        updated_dinosaur = Dinosaur.find(dinoasaur.id)
        #Requesting the response in JSON and storing it in a variable
        expect(response).to have_http_status(200)
        #Testing the specific updated value of age
        expect(updated_dinosaur.age).to eq 67000000
        end
    end

    describe "DELETE / destroy" do
        it 'deletes a dinosaur' do
        dinosaur_params = {
            dinosaur: {
                name: 'Tyrannosaurus Rex',
                age: 66000000,
                diet: 'Canivore',
                enjoys: 'Visits to the dentist for his many large serated teeth.',
                image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
            }
        }

        #HTTP request
        post '/dinosaurs', params: dinosaur_params
        #Searching for last instance created in database
        dinosaur = Dinosaur.last
        #Retriveing all instances in the database
        dinosaurs = Dinosaur.all

        #HTTP request
        delete "/dinosaurs/#{dinosaur.id}"
        #Requesting the response in JSON and storing it in a variable
        expect(response).to have_http_status(200)
        #Verifying the instance was deleted and the database is empty
        expect(dinosaurs).to be_empty
        end
    end

    describe "cannot create a dinosaur without valid attributes" do 
        it "doesn't create a dinosaur without a name" do 
            dinosaur_params = {
                dinosaur: {
                    age: 69000000,
                    diet: 'Herbavore(Vegan)',
                    enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
                    image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649'
                }
            }
        post '/dinosaurs', params: dinosaur_params 
        expect(response.status).to eq 422

        dinosaur = JSON.parse(response.body)
        expect(dinosaur['name']).to include "can't be blank"
        end

        it "doesn't create a dinosaur without an age" do 
            dinosaur_params = {
                dinosaur: {
                    name: 'Tyrannosaurus Rex',
                    diet: 'Herbavore(Vegan)',
                    enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
                    image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649'
                }
            }

            post '/dinosaurs', params: dinosaur_params 
            expect(response.status).to eq 422
    
            dinosaur = JSON.parse(response.body)
            expect(dinosaur['age']).to include "can't be blank"
        end

        it "doesn't create a dinosaur without an diet" do 
            dinosaur_params = {
                dinosaur: {
                    name: 'Tyrannosaurus Rex',
                    age: 69000000,
                    enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.',
                    image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649'
                }
            }

            post '/dinosaurs', params: dinosaur_params 
            expect(response.status).to eq 422
    
            dinosaur = JSON.parse(response.body)
            expect(dinosaur['diet']).to include "can't be blank"
        end

        it "doesn't create a dinosaur without an enjoys" do 
            dinosaur_params = {
                dinosaur: {
                    name: 'Tyrannosaurus Rex',
                    age: 69000000,
                    diet: 'Herbavore(Vegan)',
                    image: 'https://static.wikia.nocookie.net/jurassicpark/images/5/52/Jurassic_world_fallen_kingdom_triceratops_by_sonichedgehog2-dc9dwcu.png/revision/latest?cb=20180427200649'
                }
            }

            post '/dinosaurs', params: dinosaur_params 
            expect(response.status).to eq 422
    
            dinosaur = JSON.parse(response.body)
            expect(dinosaur['enjoys']).to include "can't be blank"
        end

        it "doesn't create a dinosaur without an image" do 
            dinosaur_params = {
                dinosaur: {
                    name: 'Tyrannosaurus Rex',
                    age: 69000000,
                    diet: 'Herbavore(Vegan)',
                    enjoys: 'Enjoys long walks in the rainforest and using its large skull to make a path.'
                }
            }

            post '/dinosaurs', params: dinosaur_params 
            expect(response.status).to eq 422
    
            dinosaur = JSON.parse(response.body)
            expect(dinosaur['image']).to include "can't be blank"
        end
    end

    
    describe "doesn't update a dinosaur without valid attributes" do
        it "doesn't update a dinosaur" do
        dinosaur_params = {
            dinosaur: {
                name: 'Tyrannosaurus Rex',
                age: 66000000,
                diet: 'Canivore',
                enjoys: 'Visits to the dentist for his many large serated teeth.',
                image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
            }
        }

        #HTTP request
        post '/dinosaurs', params: dinosaur_params
        #Storing the last created instance into a variable. .last is better because if you use .first and there are multiple entries in the database, it can potentially pull a different entry than the one created in the testing method.
        dinoasaur = Dinosaur.last

        #Updated instance
        updated_dinosaur_params = {
            dinosaur: {
                name: 'Tyrannosaurus',
                age: 66000000,
                diet: 'Canivore',
                enjoys: 'Visits to the dentist for his many large serated teeth.',
                image: 'https://upload.wikimedia.org/wikipedia/en/d/d2/Rexy-_the_Jurassic_Park_Tyrannosaurus_rex.png'
            }
        }

        #HTTP request using Ruby string interpolation to update a specific id
        patch "/dinosaurs/#{dinoasaur.id}", params: updated_dinosaur_params
        #Storing the update dinosaur instance into a variable
        updated_dinosaur = Dinosaur.find(dinoasaur.id)
        #Requesting the response in JSON and storing it in a variable
        expect(response.status).to eq 200
        #Testing the specific updated value of age
        expect(updated_dinosaur.age).to eq 66000000
        end
    end
end

