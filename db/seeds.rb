# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.create(lat: 14.552020, long: 120.989255, name: 'UHack', email: 'katpadillaaa@gmail.com')
Tipper.create(name: 'KatPadi', account_num: rand.to_s[2..13], email: 'hello@katpadi.ph', password: '12345678', photo_url: "http://lorempixel.com/150/150/people/")
Tipper.create(name: 'Gino O', account_num: rand.to_s[2..13], email: 'gino.oblena@gmail.com', password: '12345678', photo_url: "http://lorempixel.com/150/150/people/")
Tipper.create(name: 'Joseph Dayo', account_num: rand.to_s[2..13], email: 'joseph.dayo@gmail.com', password: '12345678', photo_url: "http://lorempixel.com/150/150/people/")

Tipee.create(merchant_id: 1, name: 'Servant MJ', account_num: rand.to_s[2..13], qr_code: SecureRandom.uuid)
Tipee.create(merchant_id: 1, name: 'Kuya Marvin', account_num: rand.to_s[2..13], qr_code: SecureRandom.uuid)
Tipee.create(merchant_id: 1, name: 'Manong Peter', account_num: rand.to_s[2..13], qr_code: SecureRandom.uuid)
