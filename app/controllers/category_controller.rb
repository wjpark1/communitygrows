class CategoryController < ActionController::Base
    layout "base"
    before_filter :authenticate_user!

    def index
    	@categories = Category.all
    end

    def new_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    end
    
    def create_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    	category = params[:category]
    	if category[:name].to_s == "" then
    		flash[:notice] = "Please fill in the category name field."
    		redirect_to new_category_path
    	elsif Category.has_name?(category[:name]) then
    		flash[:notice] = "The category name provided already exists. Please enter a different name."
    		redirect_to new_category_path
    	else
    		Category.create!(:name => category[:name])
    		flash[:notice] = "The category #{category[:name]} was successfully created!"
    		if Rails.env.production?
                User.all.each do |user| 
                    NotificationMailer.new_document_email(user, Document.find_by_title(@title)).deliver
                end
            end
    		redirect_to category_index_path
    	end
    end

    def edit_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    	@id = params[:id] 
        @category = Category.find(@id)
        @categories = Category.all
    end

    def update_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    	@category = Category.find(params[:id])
    	category = params[:category]
    	if category[:name].to_s == '' then
    		flash[:notice] = "Please fill in the category name field."
    		redirect_to edit_category_path
    	elsif Category.has_name?(category[:name].to_s)
    		flash[:notice] = "The category name provided already exists. Please enter a different name."
    		redirect_to edit_category_path
    	else
    		@category.update_attributes!(:name => category[:name].to_s)
    		if Rails.env.production?
                User.all.each do |user| 
                    NotificationMailer.document_update_email(user, Document.find_by_title(file[:title])).deliver
                end
            end
            flash[:notice] = "Categroy with name [#{@category.name}] updated successfully and email was successfully sent."
            redirect_to category_index_path
    	end
    		
    end

    def delete_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    	@category = Category.find(params[:id])
        @category.destroy!
        flash[:notice] = "Category with name #{@category.name} deleted successfully."
    	redirect_to category_index_path
    end

    def hide_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    	category = Category.find(params[:id])
    	category.hide
    	flash[:notice] = "#{category.name} successfully hidden."
    	redirect_to category_index_path
    end

    def show_category
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
    	category = Category.find(params[:id])
    	category.show
    	flash[:notice] = "#{category.name} successfully shown."
    	redirect_to category_index_path
    end

end
