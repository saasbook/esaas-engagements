module EngagementsHelper
  def engagement_short_name(engagement)
    descr = "Engagement from #{engagement.start_date.strftime '%F'}"
    if (coach = engagement.coach.try(:name))
      descr << " with #{coach}"
    end
    if (org = engagement.coaching_org.try(:name))
      descr << " (#{org}"
    end
    descr << ")"
    descr
  end
end
