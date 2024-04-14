class TemplatesController < ApplicationController

    def new
        @template = Template.new  
    end 

    def create 
        @template = Template.new(template_params)

        if @template.save 
            flash[:notice] = "Template added successfully"
            redirect_to emails_path
        else
            flash[:alert] = "The template cannot be saved"
            render :new, status: :unprocessable_entity 
        end
    end

    private 
        def template_params
            params.require(:template).permit(:name, :body)
        end
end
