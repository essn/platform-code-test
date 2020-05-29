require 'calculate_award_quality'

def update_quality(awards)
  awards.each do |award|
      updater = CalculateAwardQuality.run(
        name: award.name,
        initial_expires_in: award.expires_in,
        initial_quality: award.quality,
      )
      
      award.quality = updater.new_quality
      award.expires_in = updater.new_expires_in
  end
end
