# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    status { 'working' }
    association :requester, factory: :user
    association :user_assigned, factory: :user
  end
end
