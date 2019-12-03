class PetsController < ActionController::Base

    # skip_before_action(:verify_authenticity_token)

    def index
        @pets = Pet.all
    end

    def show
        @pet = Pet.find_by({ id: params[:id] }) 
    end

    def edit
        @owners = Owner.all
        @pet = Pet.find_by({ id: params[:id] }) 
    end

    def update
        if session[:owner_id] != nil
            @pet = Pet.find_by({ id: params[:id] })
            if @pet.owner_id == session[:owner_id]
                @pet.update(filtered_params[:pet])
                redirect_to "/pets/#{@pet.id}"
            end
        end
    end


    def filtered_params
        return params.permit({
            pet:[
                :name, 
                :noise,
                :owner_id
            ]
        })

        # Same As
        # return {
        #     pet: {
        #         name: params[:pet],
        #         noise: params[:noise],
        #         owner_id: params[:owner_id]
        #     }
        # }
    end


end