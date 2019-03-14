
require 'pry'
class PetsController < ApplicationController


  # Create
  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
   @pet = Pet.create(params[:pet])
    if !params["pet"]["name"].empty?
       if !params["owner"]["name"].empty?   #associate with new owner
        owner = Owner.create(params[:owner])
        owner.pets << @pet
       else
        owner = Owner.find(params["pet"]["owner_id"])
        #binding.pry
        owner.pets << @pet
       end
    end
    redirect to "pets/#{@pet.id}"
  end

  # Read
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end


  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end


  # Update
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

    patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    #binding.pry
      if !params[:owner][:name].empty?
        owner = Owner.create(params[:owner])
        owner.pets << @pet
      else
        @owner = Owner.find(params[:pet][:owner_id][0])
        @pet.update(params[:pet])
      end
    redirect to "pets/#{@pet.id}"
  end
end
