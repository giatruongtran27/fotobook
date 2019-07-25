users = User.create([
  {
    email:'admin@admin.com',
    first_name: 'admin',
    last_name: 'root',
    password: 123456,
    password_confirmation: 123456,
    admin: 1
  },
  {
    email:'giatruong1@gmail.com',
    first_name: 'tran',
    last_name: 'truong',
    password: 123456,
    password_confirmation: 123456
  },
  {
    email:'test1@gmail.com',
    first_name: 'nguyen',
    last_name: 'john',
    password: 123456,
    password_confirmation: 123456
  },
  {
    email:'marry123@gmail.com',
    first_name: 'le',
    last_name: 'marry',
    password: 123456,
    password_confirmation: 123456
  },
  {
    email:'army1@gmail.com',
    first_name: 'son',
    last_name: 'army',
    password: 123456,
    password_confirmation: 123456
  },
  {
    email:'kamy@gmail.com',
    first_name: 'rrr',
    last_name: 'tran',
    password: 123456,
    password_confirmation: 123456
  }
])

temp_desc = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
  quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo'

users.each do |user|
  photo_params = []
  for i in 1..9
    params = {
      title: 'Lorem ipsum dolor sit amet.',
      description: temp_desc,
      image:  File.open(File.join(Rails.root, 'app/assets/images/img' << rand(1..9).to_s << '.jpeg')),
      sharing_mode: :public_mode
    }
    photo_params.push params
  end
  user.photos.create(photo_params)
end

users.each do |user|
  album_params = []
  for i in 1..5
    params = {
      title:'Lorem ipsum dolor sit amet.',
      description:temp_desc,
      sharing_mode: :public_mode
    }
    album_params.push params
  end
  user.albums.create(album_params)
end

Album.find_each do |album|
  pics_params = []
  for i in 1..5
    params = {
      image:  File.open(File.join(Rails.root, 'app/assets/images/img' << rand(1..9).to_s << '.jpeg'))
    }
    pics_params.push params
  end
  album.pics.create(pics_params)
end