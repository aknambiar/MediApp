class DoctorsController < ApplicationController
  helper DoctorsHelper

  def index
    @doctors = Doctor.all
    @next_available = @doctors.map(&:next_available)
  end
end
