# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
# Seed an initial admin user using environment variables.
admin_email = ENV["ADMIN_EMAIL"]
admin_password = ENV["ADMIN_PASSWORD"]

if admin_email.to_s.strip.empty? || admin_password.to_s.strip.empty?
  puts "[db:seed] Skipping admin seed: set ADMIN_EMAIL and ADMIN_PASSWORD"
else
  if defined?(User)
    user = User.find_or_initialize_by(email_address: admin_email)
    if user.new_record?
      user.password = admin_password
      user.password_confirmation = admin_password
      user.save!
      puts "[db:seed] Created admin user: #{admin_email}"
    else
      puts "[db:seed] Admin user already exists: #{admin_email} (password unchanged)"
    end
  end
end

if defined?(HomePage)
  HomePage.first_or_create!(title: "Home") do |page|
    page.content = <<~HTML
      <h2>Welcome to your new home page</h2>
      <p>Use the edit button to introduce yourself, highlight featured work, or share announcements.</p>
    HTML
  end
end
