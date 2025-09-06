# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
admin_email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password")

if defined?(User)
  user = User.find_or_initialize_by(email_address: admin_email)
  if user.new_record?
    user.password = admin_password
    user.password_confirmation = admin_password
    user.save!
    puts "Seeded admin user: #{admin_email} / #{admin_password}"
  else
    puts "Admin user already exists: #{admin_email}"
  end
end
