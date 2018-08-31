module ApplicationHelper
  def alerts
		alert = (flash[:alert] || flash[:error] || flash[:notice])
    if alert
      js add_gritter(alert, sticky: false, time: 3000)
    end
	end
end
