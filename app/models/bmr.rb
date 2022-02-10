class BMR
    attr_accessor :user
    
    def initialize(user)
        @user = user
    end

    #NOTE: 基礎代謝
    def calc_bmr
        13.397*@user.weight + 4.799*@user.height - 5.677*@user.age+88.362
    end

    def calc_span
        (@user.goal.deadline - @user.goal.startday).to_i
    end

    #NOTE: 7200は、脂肪を1kg減らすのに必要なカロリー数
    def calc_absorb_calorie
        self.calc_bmr*1.1 - 7200*@user.goal.slim/self.calc_span
    end

    # NOTE:　今から期限までに目標を守ったとしたら、最終的な結果予想は以下
    #        {(1日の消費カロリー - 目標摂取カロリー)*残りの期間} / 7200kcal
    def calc_predicted_result
        ((self.calc_bmr*1.1 - self.calc_absorb_calorie)*(@user.goal.deadline - Date.today))/7200
    end
end


