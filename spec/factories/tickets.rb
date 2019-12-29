# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    status { 'working' }
    association :requester, factory: :user
    association :user_assigned, factory: :user

    factory :ticket_with_replies do
      transient do
        replies_count { 2 }
      end

      after(:create) do |ticket, evaluator|
        create_list(:reply, evaluator.replies_count, ticket: ticket)
      end
    end
  end
end
