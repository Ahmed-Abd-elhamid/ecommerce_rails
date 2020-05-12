class Copoun < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product, optional: true
  enum expiration_type: [ :time, :number_of_usage ]
  enum deduction_type: [ :percentage, :amount_of_money ]

  validates :code, :expiration_type, :deduction_type, presence: true
  validates :expiration_time, presence: true, if: -> {self.expiration_type == "time"}
  validates :expiration_number, presence: true, if: -> {self.expiration_type == "number_of_usage"}
  validates :deduction_percentage, presence: true, if: -> {self.deduction_type == "percentage"}
  validates :deduction_amount, presence: true, if: -> {self.deduction_type == "amount_of_money"}
  validates :expiration_number,:deduction_amount, :deduction_percentage, :numericality => { :greater_than_or_equal_to => 0 }

  validate :expiration_date_cannot_be_in_the_past
  def expiration_date_cannot_be_in_the_past
    if expiration_time.present? && expiration_time < Date.today
      errors.add(:expiration_time, "can't be in the past")
    end
  end  

  rails_admin do 
    create do
      configure :user do
        hide
      end
      configure :product do
        hide
      end
    end
  end
end