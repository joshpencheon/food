#coding: utf-8

module ApplicationHelper
  def format_price(price, include_unit = true)
    format_string = include_unit ? '£%n' : '%n'
    number_to_currency(price, :precision => 2, :format => format_string)
  end
end
