admin = AdminUser.find_by(email: "admin@superex.ca")

if admin.nil?
  AdminUser.create!(
    email: "admin@superex.ca",
    password: "password",
    password_confirmation: "password"
  )
end