# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    status { 0 }
  end
end
