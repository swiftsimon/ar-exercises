require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'

puts "Exercise 7"
puts "----------"

### Exercise 7: Validations for both models

# 1. Add validations to two models to enforce the following business rules:
#   * Employees must always have a first name present
#   * Employees must always have a last name present
#   * Employees have a hourly_rate that is a number (integer) between 40 and 200
#   * Employees must always have a store that they belong to (can't have an employee that is not assigned a store)
#   * Stores must always have a name that is a minimum of 3 characters
#   * Stores have an annual_revenue that is a number (integer) that must be 0 or more
# 2. Ask the user for a store name (store it in a variable)
# 3. Attempt to create a store with the inputted name but leave out the other fields (annual_revenue, mens_apparel, and womens_apparel)
# 4. Display the error messages provided back from ActiveRecord to the user after you attempt to save/create the record


# Employee table layout
# first_name: "Khurram", last_name: "Virani", hourly_rate: 60


class Employee < ActiveRecord::Base
  belongs_to :store
  validates_associated :store

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hourly_rate, numericality: { only_integer: true }
  validate :rate_ok



  private

  def rate_ok
    if !hourly_rate || hourly_rate < 40 || hourly_rate > 50
      errors.add(:hourly_rate, 'Salary Range Error')
    end
  end
end

  # Store table layout
  # name: 'Burnaby',
  # annual_revenue: 300000,
  # mens_apparel: true,
  # womens_apparel: true)


class Store < ActiveRecord::Base
  has_many :employees

  validates :name, length: { minimum: 3 }
  validates :annual_revenue, numericality: { only_integer: true, greater_than: 0 }

end


puts "Please select a store name"
user_input = gets.chomp


begin
Store.create!(
  name: '#{user_input}',
 )
  # look out for specific error
rescue ActiveRecord::RecordInvalid => e
  puts "Your error is #{e}"
end



