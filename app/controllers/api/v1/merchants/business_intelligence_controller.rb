class Api::V1::Merchants::BusinessIntelligenceController < ApplicationController
 def most_revenue
   render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity].to_i))
 end

 def merchant_revenue
   render json: RevenueSerializer.new(Merchant.merchant_revenue(params[:id]))
 end

 def most_items
   render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
 end

 def revenue_across_dates
   render json: RevenueSerializer.new(Invoice.revenue_across_dates(params[:start], params[:end]))
 end
end
