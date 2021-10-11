class BMR
    attr_accessor :user
    
    def initialize(user)
        @user = user
    end

    def calc_bmr
        13.397*user.weight + 4.799*user.height - 5.677*user.age+88.362
    end
end


