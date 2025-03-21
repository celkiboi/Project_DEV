class Setting < ApplicationRecord
  validates :remind_after_quantity, presence: true, numericality: { greater_than: 0 }
  validates :remind_after_unit, presence: true, inclusion: { in: %w[days months] }
  validates :reminder_email_text, presence: true

  def self.instance
    first_or_create!(
      remind_after_quantity: 1,
      remind_after_unit: "months",
      reminder_email_text: "This is a default reminder email text."
    )
  end
end
