class Post < ApplicationRecord
  validates :title,presence:true
  validates :start_date,presence:true
  validates :end_date,presence:true
  validate :start_end_check

  def start_end_check
    # 10~13目の行がないと開始日や終了日に入力がない場合にエラー表示されるため記述
    if start_date == nil 
      puts "start_date is nil"
    elsif end_date == nil
      puts "end_date is nil"
    elsif start_date > end_date 
      errors.add(:end_date, "の日付を正しく入力してください。") 
    elsif self.start_date > self.end_date 
      errors.add(:end_date, "の日付を正しく記入してください。") 
    elsif  Date.today > self.start_date  
      errors.add(:start_date,"の日付は今日以降にしてください。")
    end  
  end

  scope :latest, -> {order(created_at: :desc )}
  scope :old, -> {order(created_at: :asc )}
  scope :start, -> {order(start_date: :asc )}
end
