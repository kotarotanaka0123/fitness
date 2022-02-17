class PaymentController < ApplicationController

    def index
        # price情報からproduct情報を取り出す。
        @prices = Stripe::Price.list()[:data]
        @payments = Payment.where(payment_status: "仮払い")
    end

    def show
        @price = Stripe::Price.retrieve(params[:id])
        @product = Stripe::Product.retrieve(@price[:product])
        @payment = current_user.payments.find_by(product_id: @product.id)
    end

    def create
        @product = Stripe::Product.retrieve(params[:product_id])

        result = StripePaymentService.new(params, @product).execute
        if result.success
            redirect_to temporary_complete_payment_path(result.payment_id) #仮払い完了画面へ
        else
            #TODO: 失敗した場合
        end

        # begin 

        #     # ActiveRecord::Base.transaction do
        #     #     @product.reserve = "仮購入"
        #     #     @product.save

        #     #     raise "Already paid" if @product.payment.present?
        #     #     raise "parameter error" unless params[:amount].present? && params[:stripeEmail].present? && params[:stripeToken].present?
        #     # end


        #     ########################## Stripe (決済) ###############################
        #     customer = Stripe::Customer.create(
        #         email: params[:stripeEmail],
        #         source: params[:stripeToken]
        #     )

        #     charge = Stripe::Charge.create(
        #         customer: customer.id,
        #         amount: params[:amount],
        #         description: "「#{@product.name}」の決済",
        #         currency: 'jpy',
        #         receipt_email: params[:stripeEmail],
        #         metadata: {'仮払い' => "1回目"},
        #         capture: false
        #     )

        #     ###############決済記録を作成###################################################
        #     # stripeのcheckoutフォームから送られてきたパラメーターでpaymentのインスタンスを作成
        #     payment = current_user.payments.new(payment_params)

        #     payment.email = customer.email # 支払った人がstripeのcheckoutフォームに入力したemail(支払い完了後、stripeからこのメールアドレスに支払い完了メールが送られる)
        #     payment.description = charge.description #決済の概要
        #     payment.currency = charge.currency  #通貨
        #     payment.customer_id = customer.id   # stripeのcustomerインスタンスのID
        #     payment.payment_date = Time.current # payment_date(支払いを行った時間)は現在時間を入れる
        #     payment.payment_status = "仮払い" # payment_status(この支払い)は仮払い状態(stripeのcaptureをfalseにしている)
        #     payment.uuid = SecureRandom.uuid  # 請求書の番号としてuuidを用意する
        #     payment.charge_id = charge.id  # 返金(refund)の時に使うchargeのIDをpaymentに保存しておく
        #     payment.stripe_commission = (charge.amount * 0.036).round  # stripeの手数料(3.6%)分の金額
        #     payment.amount_after_subtract_commission = charge.amount - payment.stripe_commission  # stripeの手数料(3.6%)分を引いた金額(依頼者が払った96.4%の金額)
        #     payment.receipt_url = charge.receipt_url  # この決済に対するstripeが用意してくれる領収書のURL
        #     payment.product_id = @product.id
        #     payment.product_name = @product.name
        #     payment.save!

            # redirect_to temporary_complete_payment_path(payment.id) #仮払い完了画面へ

    #     # stripe関連でエラーが起こった場合
    #     rescue Stripe::CardError => e
    #         flash[:error] = "#決済(stripe)でエラーが発生しました。{e.message}"
    #         render :temporary_complete

    #     # Invalid parameters were supplied to Stripe's API
    #     rescue Stripe::InvalidRequestError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
    #         render :temporary_complete

    #     # Authentication with Stripe's API failed(maybe you changed API keys recently)
    #     rescue Stripe::AuthenticationError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
    #         render :temporary_complete

    #     # Network communication with Stripe failed
    #     rescue Stripe::APIConnectionError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
    #         render :temporary_complete

    #     # Display a very generic error to the user, and maybe send yourself an email
    #     rescue Stripe::StripeError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
    #         render :temporary_complete

    #     # stripe関連以外でエラーが起こった場合
    #     rescue => e
    #         flash.now[:error] = "エラーが発生しました#{e.message}"
    #         render :temporary_complete
    #     end    
    # end

    # def temporary_complete
    #     @payment = Payment.find(params[:id])
    # end

    # def pay_complete
    #     payment = Payment.find(params[:id])
    
    #     begin
    
    #         ActiveRecord::Base.transaction  do

    #             payment.payment_status = "完了" #支払い状況
    #             payment.save!

    #             #仮払いをcaputureして決済を完了させる
    #             charge_id = payment.charge_id
    #             charge = Stripe::Charge.retrieve(charge_id) #retrieveメソッドで仮払いしたchargeインスタンスを引っ張ってくることができる
    #             charge.capture #captureメソッドを使うと、本決済となり、実際にクレジットカードから決済が行われる。
    #         end

    #         redirect_to  complete_payment_index_path #本決済完了画面へ
    
    #     #stripe関連でエラーが起こった場合
    #     rescue Stripe::CardError => e
    #         flash.now[:error] = "決済でエラーが発生しました。#{e.message}"
    #         render :new
    
    #     # Invalid parameters were supplied to Stripe's API
    #     rescue Stripe::InvalidRequestError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
    #         render :new
    
    #     # Authentication with Stripe's API failed(maybe you changed API keys recently)
    #     rescue Stripe::AuthenticationError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
    #         render :new

    #     # Network communication with Stripe failed
    #     rescue Stripe::APIConnectionError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
    #         render :new

    #     # Display a very generic error to the user, and maybe send yourself an email
    #     rescue Stripe::StripeError => e
    #         flash.now[:error] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
    #         render :new
    #     ########################################################################################
    #     # 下のレスキューはstripe関係以外でのエラーが起こった時に発動する
    #     rescue => e
    #         flash.now[:error] = "エラーが発生しました#{e.message}"
    #         render :new
    #     end
    end

    def cancel
        Stripe::Refund.create({charge: Payment.find(params[:id]).charge_id})
        Stripe::Customer.delete(Payment.find(params[:id]).customer_id)
        Payment.delete(params[:id])

        redirect_to payment_index_path
    end

    private

    def payment_params
        params.permit(:product_id)
    end
end
