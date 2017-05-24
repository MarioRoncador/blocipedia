class CollaboratorsController < ApplicationController
  def new
     @users = User.all
     @collaborator = Collaborator.new
   end
   def create
     @user = User.find(params[:collaborators][:user_id])
     @wiki = Wiki.find(params[:collaborators][:wiki_id])
     @collaborator = Collaborator.new(wiki: @wiki, user: @user)

     if @collaborator.save
       flash[:notice] = "#{@user.name} as a collaborator"
       redirect_to wiki_path(id: params[:collaborators][:wiki_id])
     else
       flash[:error] = @collaborator.errors.full_messages.to_sentence
       render template: "wikis/edit"
     end

   end

   def destroy



     @collaborator = Collaborator.find(params[:id])
     @wiki = @collaborator.wiki
     if @collaborator.destroy
       flash[:notice] = "Collaborator was removed successfully"
       redirect_to edit_wiki_path(@wiki)
     else
       flash[:error] = "There was an error removing a collaborator.Please try again"
       render "show"
     end
   end
end
