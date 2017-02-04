class SessionsController < ApplicationController
	def new
		# renderöi kirjautumissivun
	end

	def create
		# haetaan usernamea vastaava käyttäjä tietokannasta
		user = User.find_by username: params[:username]
		if user.nil?
			redirect_to :back, notice: "User #{params[:username]} does not exist!"
		else
			# talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa
			session[:user_id] = user.id 
			# uudelleenohjataan käyttäjä omalle sivuleen
			redirect_to user, notice: "Welcome back!"
		end
	end

	def destroy
		# nollataan sessio
		session[:user_id] = nil
		# uudelleenohjataan sovellus pääsivulle
		redirect_to :root
	end
end
