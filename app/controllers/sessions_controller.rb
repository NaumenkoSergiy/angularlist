class SessionsController < Devise::SessionsController
  def create
    client = TopTalApi::Client.new(params[:email], params[:password])
    respond_to do |f|
      f.json {
        if client.authenticate!
          render json: { result: :ok, access_token: client.access_token }
        else
          render json: { result: :error, message: 'Invalid email or password' }
        end
      }
      f.html {
        if client.authenticate!
          session[:token] = client.access_token
          redirect_to root_path
        else
          flash[:alert] = 'Invalid email or password'
          render :new
        end
      }
    end
  end
end
