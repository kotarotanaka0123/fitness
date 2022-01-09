class CommunityController < ApplicationController
    layout 'community'

    before_action :authenticate_user!

    def index
    end
end
