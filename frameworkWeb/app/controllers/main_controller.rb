class MainController < ApplicationController
    def index
        @users = User.all
                
        if current_user == nil
            @userAtual=""
        else
            if current_user.role == "admin"
                @userAtual="admin"
            else
                @userAtual="padrao"
            end
        end
    end
end
