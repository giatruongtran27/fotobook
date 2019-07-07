# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

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

# albums = Album.create([
#   {
#     title:'album1',
#     description:'description of album 1',
#     sharing_mode: true,
#     user_id: 1
#   },
#   {
#     title:'album2',
#     description:'description of album 2',
#     sharing_mode: false,
#     user_id: 2
#   },
#   {
#     title:'album3',
#     description:'description of album 3',
#     sharing_mode: true,
#     user_id: 3
#   },
#   {
#     title:'album3_2',
#     description:'description of album 3_2',
#     sharing_mode: false,
#     user_id: 3
#   },
#   {
#     title:'album4',
#     description:'description of album 4',
#     sharing_mode: false,
#     user_id: 4
#   }
# ])

# photos = Photo.create([
#   {
#     title: 'image1',
#     description: 'description of image 1',
#     img_url: 'img1.jpeg',
#     sharing_mode: true,
#     user_id: '1'
#   },
#   {
#     title: 'image2',
#     description: 'description of image 2',
#     img_url: 'img2.jpeg',
#     sharing_mode: true,
#     user_id: '1'
#   },
#   {
#     title: 'image3',
#     description: 'description of image 3',
#     img_url: 'img3.jpeg',
#     sharing_mode: false,
#     user_id: '2'
#   },
#   {
#     title: 'image4',
#     description: 'description of image 4',
#     img_url: 'img4.jpeg',
#     sharing_mode: false,
#     user_id: '3'
#   }
# ])
# album = Album.create({
#   title:'album1',
#   description:'description of album 1',
#   sharing_mode: true,
#   user_id: 1
# })
# p1 = Photo.find(1)
# p2 = Photo.find(2)
# p3 = Photo.find(3)
# p4 = Photo.find(4)
# a1 = Album.find(1)
# a2 = Album.find(2)
# p1.albums << a1
# p2.albums << a1
# p3.albums << a1
# p4.albums << a2

# p = Photo.create({
#   title: 'image1',
#   description: 'description of image 1',
#   img_url: 'img1.jpeg',
#   sharing_mode: true,
#   user_id: '1'
# })
# p.albums << album

