class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
if params["pet"]["owner_ids"] != nil
  @pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_ids"][0].to_i)
elsif
  !params["owner"]["name"].empty?
  @pet = Pet.create(name: params["pet"]["name"])
  @owner = Owner.create(name: params["owner"]["name"])
  @pet.owner_id = @owner.id
  @pet.save
end
    redirect to "pets/#{@pet.id}"
  end



  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all    
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
  if !params[:pet].keys.include?("owner_ids")
    params[:pet]["owner_ids"] = []
    end
  @pet = Pet.find(params[:id])
  @pet.name=params["pet"]["name"]
  @pet.owner_id=params["pet"]["owner_ids"][0].to_i
  @pet.save

  if !params["owner"]["name"].empty?
    @owner = Owner.create(params["owner"])
    @owner.pets << Pet.create(name: params["pet"]["name"])
    @pet.owner_id=@owner.id
  end
    redirect to "pets/#{@pet.id}"
  end
end