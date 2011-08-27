class Notifier < ActionMailer::Base
  default from: "support@lithoslabs.com"

  def confirmation(trip)
    @trip = trip

    mail( :to => @trip.email,
          :subject => "Confirmation and info regarding your trip") do |format|
      format.html
    end
  end
end
