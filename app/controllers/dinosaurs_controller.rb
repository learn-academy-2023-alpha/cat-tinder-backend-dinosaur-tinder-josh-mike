class DinosaursController < ApplicationController

    def index
        dinosaurs = Dinosaur.all 
        render json: dinosaurs
    end

    def create
        dinosaur = Dinosaur.create(dinosaur_params)
        if dinosaur.valid?
            render json: dinosaur
        end
    end

    def update
        dinosaur = Dinosaur.find(params[:id])
        dinosaur.update(dinosaur_params)
        if dinosaur.valid?
            render json: dinosaur
        end
    end

    def destroy
        dinosaur = Dinosaur.find(params[:id])
        dinosaur.destroy
        if dinosaur.valid?
            render json: dinosaur
        end
    end

    #Strong params
    private
    def dinosaur_params
        params.require(:dinosaur).permit(:name, :age, :diet, :enjoys, :image)
    end
end
