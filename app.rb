require "sinatra"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"

class ContactsApp < Sinatra::Base
  enable :sessions

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

    get "/" do
      erb: root
    end

    #Need to do something like this:
 #   get "/" do
 #     if current_user
 #      erb :root, :locals => {:contact_database => @contact_database}
 #     else
 #       erb :root
 #     end
 #   end

    get "/login" do
      erb :login
    end

    post "/login" do
      if check_for_user
        session[:user] = check_for_user[:id]
      end
      redirect "/"
    end

    post "/logout" do
      session.clear
      redirect "/"
    end

    def check_for_user
      @user_database.select {|user| user[:username] == params[:username] && user[:password] == params[:password]}
    end
  end

# def current_user
#  if session[:id]
#    @user_database.find(session[:id])
#  end
# end
# end

# firgured out last bit after time was up
# @user_database.all.select {|user| user[:username] == params[:username] && user[:password] == params[:password]}.first