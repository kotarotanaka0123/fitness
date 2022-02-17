class StripePaymentService
    def initialize(params, product)
        @params = params
        @product = product
    end

    def execute

        begin
            
            ########################## Stripe (決済) ###############################
            customer = Stripe::Customer.create(
                email: @params[:stripeEmail],
                source: @params[:stripeToken]
            )

            charge = Stripe::Charge.create(
                customer: customer.id,
                amount: @params[:amount],
                description: "「#{@product.name}」の決済",
                currency: 'jpy',
                receipt_email: @params[:stripeEmail],
                metadata: {'仮払い' => "1回目"},
                capture: false
            )

            ###############決済記録を作成###################################################
            # stripeのcheckoutフォームから送られてきたパラメーターでpaymentのインスタンスを作成
            payment = current_user.payments.new(payment_params)

            payment.email = customer.email # 支払った人がstripeのcheckoutフォームに入力したemail(支払い完了後、stripeからこのメールアドレスに支払い完了メールが送られる)
            payment.description = charge.description #決済の概要
            payment.currency = charge.currency  #通貨
            payment.customer_id = customer.id   # stripeのcustomerインスタンスのID
            payment.payment_date = Time.current # payment_date(支払いを行った時間)は現在時間を入れる
            payment.payment_status = "仮払い" # payment_status(この支払い)は仮払い状態(stripeのcaptureをfalseにしている)
            payment.uuid = SecureRandom.uuid  # 請求書の番号としてuuidを用意する
            payment.charge_id = charge.id  # 返金(refund)の時に使うchargeのIDをpaymentに保存しておく
            payment.stripe_commission = (charge.amount * 0.036).round  # stripeの手数料(3.6%)分の金額
            payment.amount_after_subtract_commission = charge.amount - payment.stripe_commission  # stripeの手数料(3.6%)分を引いた金額(依頼者が払った96.4%の金額)
            payment.receipt_url = charge.receipt_url  # この決済に対するstripeが用意してくれる領収書のURL
            payment.product_id = @product.id
            payment.product_name = @product.name
            payment.save!

            return {success: true, payment_id: payment.id, error_msg: nil}

        # stripe関連でエラーが起こった場合
        rescue Stripe::CardError => e
            flash[:error] = "#決済(stripe)でエラーが発生しました。{e.message}"
            render :temporary_complete

            return {success: false, payment_id: nil, error_msg: "#決済(stripe)でエラーが発生しました。{e.message}"}

        # Invalid parameters were supplied to Stripe's API
        rescue Stripe::InvalidRequestError => e
            flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
            render :temporary_complete

            return {success: false, payment_id: nil, error_msg: "#決済(stripe)でエラーが発生しました。{e.message}"}

        # Authentication with Stripe's API failed(maybe you changed API keys recently)
        rescue Stripe::AuthenticationError => e
            flash.now[:error] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
            render :temporary_complete

        # Network communication with Stripe failed
        rescue Stripe::APIConnectionError => e
            flash.now[:error] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
            render :temporary_complete

        # Display a very generic error to the user, and maybe send yourself an email
        rescue Stripe::StripeError => e
            flash.now[:error] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
            render :temporary_complete

        # stripe関連以外でエラーが起こった場合
        rescue => e
            flash.now[:error] = "エラーが発生しました#{e.message}"
            render :temporary_complete
        end    
    end

end