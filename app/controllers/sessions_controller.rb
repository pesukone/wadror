class SessionsController < ApplicationController
	def new
		# renderöi kirjautumissivun
	end

	def create
		# haetaan usernamea vastaava käyttäjä tietokannasta
		user = User.find_by name: params[:username]

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

	def create_oauth
		info = request.env['omniauth.auth'].info
		user = User.find_by name:"#{info.nickname}"
		if not user.nil?
			if user.banned?
				redirect_back(fallback_location: root_path, notice: "Your account is frozen, please contact admin")
				return
			end
			session[:user_id] = user.id
			redirect_to user_path(user)
		else
			account = User.create name: info.nickname, github: true
			session[:user_id] = account.id
			redirect_to user_path(account)
		end
	end
end
