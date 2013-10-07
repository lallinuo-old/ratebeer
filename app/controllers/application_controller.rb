class ApplicationController < ActionController::Base
  protect_from_forgery
  # määritellään, että metodi current_user tulee käyttöön myös näkymissä

  helper_method :current_user, :currently_signed_in?, :user_signed_in?

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end


  def currently_signed_in?(user)
    current_user == user
  end

  def user_signed_in?
    current_user
  end



  def ensure_that_signed_in
    redirect_to signin_path, :notice => 'you should be signed in' if current_user.nil?
  end

  def current_user_is_bc_member?(bc)
    current_user.memberships.confirmed.each{|m|
      if m.beer_club == bc
        return true
      end
    }
    return false

  end
end
