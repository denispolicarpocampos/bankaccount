Account.delete_all
User.delete_all
Historic.delete_all

user1 = User.create(id: 1 , name: 'teste', email: 'teste1@hotmail.com', password: 'secret123')
user2 = User.create(id: 2 , name: 'teste', email: 'teste2@hotmail.com', password: 'secret123')
Account.create(id: 1, number: 1000, amount: 50.0, user_id: user1.id)
Account.create(id: 2, number: 1001, amount: 50.0, user_id: user2.id)