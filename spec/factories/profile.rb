# encoding: utf-8

FactoryGirl.define do
  factory :profile do
    name 'Horo'
    country 'BR'
    state 'São Paulo'
    city 'São Paulo'
    street 'Rua Heitor Penteado, 1540. Apt. 49'
    gmaps true
  end
end
