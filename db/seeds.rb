admin = AdminUser.find_by(email: "admin@superex.ca")

if admin.nil?
  AdminUser.create!(
    email: "admin@superex.ca",
    password: "password",
    password_confirmation: "password"
  )
end

shell_jackets = Category.find_or_create_by!(name: "Shell Jackets")
insulated_jackets = Category.find_or_create_by!(name: "Insulated Jackets")
lifestyle = Category.find_or_create_by!(name: "Lifestyle")

products = [
  {
    name: "Banff Alpine Shell",
    description: "This shell helps keep out rain and wind on wet trail days. It is light, easy to pack, and has room for a sweater underneath.",
    price: 249.99,
    stock_quantity: 15,
    on_sale: false,
    sale_price: nil,
    categories: [ shell_jackets ]
  },
  {
    name: "Assiniboine Rain Shell",
    description: "This jacket is made for steady rain and cool mountain air. The hood can be adjusted, and the simple fit is easy to move in.",
    price: 229.99,
    stock_quantity: 18,
    on_sale: true,
    sale_price: 199.99,
    categories: [ shell_jackets ]
  },
  {
    name: "Whistler Trail Shell",
    description: "This shell works well for hiking, biking, or walking around town. It blocks wind and packs away when the weather clears.",
    price: 199.99,
    stock_quantity: 20,
    on_sale: false,
    sale_price: nil,
    categories: [ shell_jackets ]
  },
  {
    name: "Jasper Down Jacket",
    description: "This down jacket helps hold in heat on cold winter days. It feels warm without being too heavy and fits under a larger shell.",
    price: 329.99,
    stock_quantity: 10,
    on_sale: false,
    sale_price: nil,
    categories: [ insulated_jackets ]
  },
  {
    name: "Robson Winter Parka",
    description: "This longer parka gives more cover in snow and cold wind. It is made for winter walks, daily travel, and time outside.",
    price: 369.99,
    stock_quantity: 8,
    on_sale: false,
    sale_price: nil,
    categories: [ insulated_jackets ]
  },
  {
    name: "Kananaskis Insulated Jacket",
    description: "This jacket gives steady warmth in cool weather. It is easy to layer and works well for hiking or everyday use.",
    price: 279.99,
    stock_quantity: 14,
    on_sale: true,
    sale_price: 239.99,
    categories: [ insulated_jackets ]
  },
  {
    name: "Birds Hill Fleece Hoodie",
    description: "This soft fleece hoodie is made for cool mornings and relaxed days. It can be worn on its own or under a jacket.",
    price: 89.99,
    stock_quantity: 25,
    on_sale: true,
    sale_price: 69.99,
    categories: [ lifestyle ]
  },
  {
    name: "Riding Mountain Crewneck",
    description: "This crewneck has a soft feel and a clean look. It is comfortable for school, travel, or a quiet day outside.",
    price: 79.99,
    stock_quantity: 24,
    on_sale: false,
    sale_price: nil,
    categories: [ lifestyle ]
  },
  {
    name: "Garibaldi Utility Vest",
    description: "This light vest has useful pockets for small items. It is easy to wear over a shirt, sweater, or hoodie.",
    price: 109.99,
    stock_quantity: 16,
    on_sale: false,
    sale_price: nil,
    categories: [ lifestyle ]
  },
  {
    name: "Fundy Trail Cap",
    description: "This simple cap has an adjustable back and a small mountain logo. It is made for sunny walks, road trips, and daily wear.",
    price: 39.99,
    stock_quantity: 30,
    on_sale: false,
    sale_price: nil,
    categories: [ lifestyle ]
  }
]

products.each do |product_data|
  product = Product.find_or_initialize_by(name: product_data[:name])

  product.description = product_data[:description]
  product.price = product_data[:price]
  product.stock_quantity = product_data[:stock_quantity]
  product.on_sale = product_data[:on_sale]
  product.sale_price = product_data[:sale_price]

  product.save!
  product.categories = product_data[:categories]
end

if AboutPage.first.nil?
  AboutPage.create!(
    title: "About Us",
    content: "Superex is a Winnipeg founded based and owned outdoor lifestyle clothing company."
  )
end

if ContactPage.first.nil?
  ContactPage.create!(
    title: "Contact Us",
    content: "Our team is always willing to help answer any questions, contact us below",
    email: "support@superex.ca",
    phone: "204-4567-123",
    business_hours: "Monday to Sunday, 10:00 AM to 8:00 PM",
    address: "303 Portage Avenue, Winnipeg, MB R3B 2B4",
    map_embed_url: "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.620871521684!2d-97.1434151!3d49.8939789!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x52ea7159a1cdfd27%3A0x51bc8e16cc3c8f8e!2sMEC%20Winnipeg!5e1!3m2!1sen!2sca!4v1784837497480!5m2!1sen!2sca"
  )
end
