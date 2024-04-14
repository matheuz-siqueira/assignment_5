class EmailsController < ApplicationController

  def index
    @emails = Email.all
  end

  def show
    @email = Email.find(params[:id])
  end
  
  def new
    
    # binding.pry
    @email = Email.new
    @templates = Template.all
  end

  def create
    
    template_params = email_params.extract!("template")
    @email = Email.new(email_params)
  
    @template = Template.find_by_id(template_params[:template])

    if @template.present?  

      @email.body = @template.body.gsub("{{-placeholder-}}", @email.body)
    end


    if @email.save
      Subscriber.all.each do |subscriber|
        NewsletterMailer.email(subscriber, @email).deliver_now
      end
      flash[:notice] = "Email sent"
      redirect_to emails_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    
    def email_params
      params.require(:email).permit! 
    end
    
end