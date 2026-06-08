class Reservation < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :room, optional: true

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guests, presence: true, numericality: { greater_than_or_equal_to: 1 }

  validate :check_in_must_be_future
  validate :check_out_must_be_after_check_in

  private

  def check_in_must_be_future
    return unless check_in.present?
    if check_in < Date.today
      errors.add(:check_in, "は本日以降の日付を選択してください")
    end
  end

  def check_out_must_be_after_check_in
    return unless check_in.present? && check_out.present?
    if check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付を選択してください")
    end
  end
end

