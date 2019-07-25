Reviewer: GiauNV / Trainee: TruongTG
-----

### Issues from last review and their status
---------

- Các file view chưa support I18n

- /app/controllers/sessions_controller.rb, file dư thừa
-->
chưa fix

- /db/seeds.rb: Nên bổ sung cho đầy đủ, ví dụ thêm album, photo
-->
chưa fix

### Jul 19, 2019

- UI cần đầu tư hơn nữa để giống với design
- Thay vì viết js thì nên viết coffee
- Thay vì viết erb thì nên viết SLIM
- /app/assets/javascripts/edit_self_profile.js
```
    messages: {
      "user[email]": {
        required: "Email is required.",
        email: "Please enter a valid email address.",
        maxlength: "Email must be less than 255 characters."
      },
      "user[first_name]": {
        required: "First Name is required.",
        maxlength: "First Name must be less than 25 characters."
      },
      "user[last_name]": {
        required: "Last Name is required.",
        maxlength: "Last Name must be less than 25 characters."
      }
    },
```
--> sử dụng https://github.com/fnando/i18n-js để support I18n cho client

- /app/controllers/photos_controller.rb
```
    def check_authorize
      if current_user.id != params[:user_id].to_i and !current_user.admin
        render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
      end
    end
```
--> áp dụng style code tránh lồng nhau nhiều cấp
```
    def check_authorize
      return unless (current_user.id == params[:user_id].to_i) || current_user.admin

      render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
    end
```

- Có sự trùng lắp code
```
render :file => "#{Rails.root}/public/404.html",  :status => 404, layout: 'errors_layout'

render :file => "#{Rails.root}/public/422.html",  :status => 422, layout: 'errors_layout'
```

Solution: lựa chọn 1 trong 2 cách sau:

    a. Tạo method dùng chung

    b. Sử dụng gem https://github.com/CanCanCommunity/cancancan để check authorization