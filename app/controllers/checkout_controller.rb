# frozen_string_literal: true

class CheckoutController < ApplicationController
  def create
    p params
    @product = Product.find(params[:product_id])
    p @product
    # @session = Stripe::Checkout::Session.create({
    #
    #                                               cancel_url: manage_posts_url,
    #                                               payment_method_types: ['card'],
    #                                               line_items: [{
    #                                                 price_data: {
    #                                                   product_data: {name: @post.content},
    #                                                   unit_amount: 2000,
    #                                                   currency: 'usd'
    #
    #                                                 },
    #                                                 quantity: 1
    #                                               }],
    #                                               mode: 'payment',
    #                                               success_url: root_url
    #                                               # metadata: { product_id: @post_id }
    #                                               # customer_email: current_user.email,
    #                                               # success_url: manage_posts_url,
    #                                               # cancel_url: manage_posts_url
    #                                             })
    @session = Stripe::Checkout::Session.create({
                                                  success_url: root_url,
                                                  cancel_url: root_url,
                                                  payment_method_types: ['card'],
                                                  line_items: [{
                                                    price_data: {
                                                      unit_amount: @product.price,
                                                      product_data: { name: @product.name},
                                                      currency: 'usd'
                                                    },
                                                    quantity: 1
                                                  }],
                                                  mode: 'payment'
                                                })
    # respond_to(&:js)
    # respond_to do |format|
    # format.js
    redirect_to @session.url, allow_other_host: true
    #   # format.js { render js: @session }
    # end
  end
end
