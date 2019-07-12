Reviewer: GiauNV / Trainee: TruongTG
-----

### Jul 12, 2019

- Có vài file coffee, xxx_herlper.rb empty, không dùng thì xóa đi, và vài file khác

- /app/assets/javascripts/application.js, không viết js trong file này, file nãy chỉ sử dụng để require

- /app/assets/javascripts/sessions.js, code không dùng thì del đi, ko comment như vậy

- /app/controllers/users/*.rb, không có custom gì cho devise controller tại sao lại tạo ra chi

- /app/controllers/albums_controller.rb, /app/controllers/feeds_controller.rb,  có nhiều logic phức tạp, cần move ra service hoặc module riêng

- /app/controllers/sessions_controller.rb, file dư thừa

- /app/controllers/users_controller.rb: nhiều logic phức tạp cần move ra service, code không dùng thì del đi thay vì comment,

- /app/views/sessions/_validate.js: sao lại có file js trong thư mục view này

- Chỉ định version cụ thể trong /Gemfile, e.g `gem 'mini_racer'` -->  `gem 'mini_racer', '~> -.2.6'`

- /db/seeds.rb: Nên bổ sung cho đầy đủ, ví dụ thêm album, photo

- Lời khen: code viết ngay ngắn, rất tốt.