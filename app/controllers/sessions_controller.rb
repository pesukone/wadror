class SessionsController < ApplicationController
	def new
		# renderöi kirjautumissivun
	end

	def create
		# haetaan usernamea vastaava käyttäjä tietokannasta
		user = User.find_by username: params[:username]

		if user.banned?
			redirect_back(fallback_location: root_path, notice: "Your account is frozen, please contact admin")
			return
		end

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to user_path(user), notice: "Welcome back!"
		else
			redirect_back(fallback_location: root_path, notice: "Username and/or password mismatch")
		end
	end

	def destroy
		# nollataan sessio
		session[:user_id] = nil
		# uudelleenohjataan sovellus pääsivulle
		redirect_to :root
	end
end
