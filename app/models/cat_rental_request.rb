class CatRentalRequest < ActiveRecord::Base
  STATUS = %w(PENDING APPROVED DENIED)
  after_initialize :set_status
  validates :status, inclusion: { in: STATUS }
  validates :cat_id, :start_date, :end_date, presence: true 
  validate :overlapping_approved_requests
  
  belongs_to :cat
  

  
  def overlapping_requests
    where_query = <<-SQL
      cat_id = :cat_id AND
      (
        (
          (:my_start_date BETWEEN start_date AND end_date)
          OR (:my_end_date BETWEEN start_date AND end_date)
        )
        OR (
          (start_date BETWEEN :my_start_date AND :my_end_date)
          OR (end_date BETWEEN :my_start_date AND :my_end_date)
        )
      )
    SQL
    
    CatRentalRequest.where(
      where_query,
      cat_id: self.cat_id, my_start_date: self.start_date,
      my_end_date: self.end_date
    )
  end
  
  def overlapping_approved_requests
    unless overlapping_requests.where(status: 'APPROVED').empty?
      errors.add(:cat_id, "overlap request for this cat")
    end
  end
  
  def approve!
    self.update(status: "APPROVED")
    overlaps = overlapping_requests
    overlaps.each{|overlap| overlap.deny!}
  end
  
  def deny!
    self.update(status: "DENIED")
  end
  
  def set_status
    self.status ||= "PENDING"
  end
  
  
end
