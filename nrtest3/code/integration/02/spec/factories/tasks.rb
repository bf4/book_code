#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    size 3
    completed_at nil

    trait :small do
      size 1
    end

    trait :large do
      size 5
    end

    trait :soon do
      due_date { 1.day.from_now }
    end

    trait :later do
      due_date { 1.month.from_now }
    end

    trait :newly_complete do
      completed_at { 1.day.ago }
    end

    trait :long_complete do
      completed_at { 6.months.ago }
    end

    factory :trivial, class: Task, traits: %i[small later]
    factory :panic, class: Task, traits: %i[large soon]

  end

end
