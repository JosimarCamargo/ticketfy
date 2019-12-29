# frozen_string_literal: true

FactoryBot.define do
  factory :reply do
    ticket
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    user
  end
end
