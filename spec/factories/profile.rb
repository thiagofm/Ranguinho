# encoding: utf-8

FactoryGirl.define do
  factory :profile do
    name 'Horo'
    country 'BR'
    state 'São Paulo'
    city 'São Paulo'
    street 'Rua Heitor Penteado, 1540. Apt. 49'
    latitude 23.5448576
    longitude(-46.6929873)
    gmaps true
  end
end
